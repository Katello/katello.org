#!/usr/bin/env ruby

require 'open3'
require 'fileutils'
require 'open-uri'
require 'json'
require 'optparse'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: ./deploy.rb [options]"
  opts.on("--pr [PR]", "Build against a pull request") { |pr| options[:pr] = pr }
  opts.parse!
end

class Deployer

  attr_accessor :versions, :pr

  BUILD_DIR = '_build'
  DEPLOY_DIR = 'public'

  def initialize(pr = nil)
    make_builddir
    make_deploymentdir
    clone_version('nightly')

    self.pr = pr_details(pr)
    puts "Testing PR #{self.pr[:id]} against branch #{self.pr[:target]}" unless self.pr.empty?

    self.versions = find_versions
    puts "Versions found: #{versions.to_s}"

    clone_versions
    build_nightly
    build_versions(@versions)
  end

  def make_builddir
    puts "Creating build directory at #{BUILD_DIR}"
    make_dir(BUILD_DIR)
  end

  def make_deploymentdir
    puts "Creating deployment directory at #{DEPLOY_DIR}"
    make_dir(DEPLOY_DIR)
  end

  def clone_versions
    @versions.each { |version| clone_version(version) }
  end

  def clone_version(version)
    Dir.chdir(BUILD_DIR) do
      syscall("git clone git://github.com/Katello/katello.org #{version}")
    end
  end

  def find_versions
    puts "Detecting available Katello versions"

    Dir.chdir(BUILD_DIR + '/nightly') do
      result = syscall('git branch -a')

      result = result.split("\n").select do |branch|
        branch.include?('remotes/origin/KATELLO-')
      end

      result.collect do |version|
        version.split('-').last
      end
    end
  end

  def build_nightly
    puts "Building nightly..."
    reset_nightly

    Dir.chdir(BUILD_DIR + '/nightly') do
      build_pr_branch('master')
      set_config("versions: #{@versions}")

      syscall("cat _config.build.yml")

      jekyll_build
      cleanup_config
    end

    FileUtils.cp_r('_build/nightly/_site/.', "public/")
  end

  def build_versions(versions)
    versions.each { |version| build_version(version) }
  end

  def build_version(version = 'nightly')
    puts "Building version #{version}"
    reset_nightly

    branch = "remotes/origin/KATELLO-#{version}"

    FileUtils.rmdir('public/docs/' + version)

    Dir.chdir(BUILD_DIR + '/' + version) do
      syscall("git checkout #{branch}")
    end

    build_pr_branch(branch.split('/').last)

    Dir.chdir(BUILD_DIR + '/nightly') do
      set_config("version: #{version}")
      set_config("versions: #{@versions}")

      syscall("rm -rf docs/")

      ['docs', '_includes/sidebars'].each do |path|
        FileUtils.mkdir_p("#{path}/#{version}")
        syscall("cp -rf ../#{version}/#{path}/* #{path}/#{version}")
      end

      jekyll_build
      cleanup_config
    end

    copy_version(version)
  end

  private

  def reset_nightly
    Dir.chdir(BUILD_DIR + '/nightly') do
      syscall('git reset HEAD --hard')
    end
  end

  def copy_version(version)
    puts "Copying #{version}"

    FileUtils.cp_r("_build/nightly/_site/docs/#{version}/.", "public/docs/#{version}")
  end

  def jekyll_build
    syscall('pwd')
    syscall('bundle install')
    syscall('jekyll build --config _config.yml,_config.build.yml')
  end

  def cleanup_config
    syscall('rm -f _config.build.yml')
  end

  def set_config(values)
    File.open('_config.build.yml', 'a') do |file|
      file.puts(values)
    end
  end

  def make_dir(directory)
    syscall("rm -rf #{directory}") if File.exists?(directory)
    syscall("mkdir #{directory}")
  end

  def syscall(*cmd)
    puts cmd if ARGV.include?('--debug')

    stdout, stderr, status = Open3.capture3(*cmd)

    if status.success?
      stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
    else
      puts stderr
      false
    end
  end

  def pr_details(pr)
    if pr
      raw = JSON.load(open("https://api.github.com/repos/katello/Katello.org/pulls/#{pr}").read)
      {:target => raw['base']['ref'], :id => pr}
    else
      {}
    end
  end

  def build_pr_branch(branch)
    if branch == pr[:target]
      syscall("git fetch origin +refs/pull/#{pr[:id]}/merge")
      syscall("git merge FETCH_HEAD")
    end
  end
end

Deployer.new(options[:pr])
