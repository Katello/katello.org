#!/usr/bin/env ruby

require 'open3'
require 'fileutils'
require 'open-uri'
require 'json'
require 'optparse'
require 'yaml'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: ./deploy.rb [options]"
  opts.on("--pr [PR]", "Build against a pull request") { |pr| options[:pr] = pr }
  opts.on("--remote [REMOTE]", "Build using a different remote") { |remote| options[:remote] = remote }
  opts.parse!
end

class Deployer

  attr_accessor :versions, :pr, :version_aliases

  BUILD_DIR = '_build'
  DEPLOY_DIR = 'public'

  def initialize(pr = nil, remote = nil)
    remote ||= 'origin'
    make_builddir
    make_deploymentdir
    clone_version('base', remote)

    self.pr = pr_details(pr)
    puts "Testing PR #{self.pr[:id]} against branch #{self.pr[:target]}" unless self.pr.empty?

    self.versions = find_versions
    self.version_aliases = find_version_aliases
    puts "Versions found: #{versions.to_s}"
    puts "Version aliases found: #{version_aliases.inspect}"
    build_base
  end

  def make_builddir
    puts "Creating build directory at #{BUILD_DIR}"
    make_dir(BUILD_DIR)
  end

  def make_deploymentdir
    puts "Creating deployment directory at #{DEPLOY_DIR}"
    make_dir(DEPLOY_DIR)
  end

  def clone_versions(remote)
    @versions.each { |version| clone_version(version, remote) }
  end

  def clone_version(version, remote)
    if remote == 'origin'
      remote_url = 'git://github.com/Katello/katello.org'
    else
      remote_url = syscall("git ls-remote --get-url #{remote}")
    end
    Dir.chdir(BUILD_DIR) do
      syscall("git clone #{remote_url} #{version}")
    end
  end

  def find_version_aliases
    config = YAML.load_file(BUILD_DIR + '/base/_config.yml')
    config['version_aliases'] || {}
  end

  def find_versions
    puts "Detecting available Katello versions"

    Dir.chdir(BUILD_DIR + '/base') do
      result = syscall('git branch -a')

      result = result.split("\n").select do |branch|
        branch.include?('remotes/origin/KATELLO-')
      end

      results = result.collect do |version|
        version.split('-').last
      end
    end
  end

  def build_base
    puts "Building nightly..."
    reset_nightly

    Dir.chdir(BUILD_DIR + '/base') do
      build_pr_branch('master')
      set_config('versions' =>  self.versions, 'version_aliases' => self.version_aliases)
      syscall("cat _config.build.yml")

      jekyll_build
      cleanup_config
    end

    FileUtils.cp_r('_build/base/_site/.', "public/")
    FileUtils.cp_r('_build/base/gpg/', "public/")
    FileUtils.rm_rf(Dir.glob('public/docs/*'))
  end

  def build_versions(versions, remote)
    versions.each { |version| build_version(version, remote) }
  end

  def build_version(version = 'nightly', remote)
    puts "Building version #{version}"
    reset_nightly

    if version == 'nightly'
      branch = "remotes/origin/master"
    else
      branch = "remotes/origin/KATELLO-#{version}"
    end

    FileUtils.rmdir('public/docs/' + version)

    Dir.chdir(BUILD_DIR + '/' + version) do
      syscall("git checkout #{branch}")
    end

    build_pr_branch(branch.split('/').last)

    Dir.chdir(BUILD_DIR + '/base') do
      set_config('version' => version, 'versions' => self.versions, 'version_aliases' => self.version_aliases)

      syscall("rm -rf docs/")
      FileUtils.mkdir('docs/')
      FileUtils.mkdir('docs/' + version)
      syscall("cp -rf ../#{version}/_config.yml .")
      syscall("cp -rf ../#{version}/docs/* docs/#{version}")
      syscall("cp -rf ../#{version}/_includes/sidebars/documentation.html* _includes/sidebars/documentation.html")

      jekyll_build
      cleanup_config
    end

    copy_version(version)
  end

  private

  def reset_nightly
    Dir.chdir(BUILD_DIR + '/base') do
      syscall('git reset HEAD --hard')
    end
  end

  def copy_version(version)
    puts "Copying #{version}"

    FileUtils.cp_r("_build/base/_site/docs/#{version}/.", "public/docs/#{version}")
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
    @config ||= {}
    @config = @config.merge(values)

    File.open('_config.build.yml', 'w') do |file|
      file.puts(values.to_yaml)
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

Deployer.new(options[:pr], options[:remote])
