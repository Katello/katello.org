#!/usr/bin/env ruby

require 'open3'
require 'fileutils'

class Deployer

  attr_accessor :versions

  BUILD_DIR = '_build'

  def initialize
    make_builddir
    clone_version('nightly')

    self.versions = find_versions
    puts "Versions found: #{versions.to_s}"

    clone_versions
    build_nightly
    build_versions(@versions)
  end

  def make_builddir
    puts "Creating build directory at #{BUILD_DIR}"

    syscall("rm -rf #{BUILD_DIR}") if File.exists?(BUILD_DIR)
    syscall("mkdir #{BUILD_DIR}")
  end

  def clone_versions
    @versions.each { |version| clone_version(version) }
  end

  def clone_version(version)
    Dir.chdir(BUILD_DIR) do
      syscall("git clone http://github.com/Katello/katello.org #{version}")
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
      set_config("versions: #{@versions}")

      syscall("cat _config.build.yml")

      jekyll_build
      cleanup_config
    end

    FileUtils.cp_r('_build/nightly/_site/.', ".")
  end

  def build_versions(versions)
    versions.each { |version| build_version(version) }
  end

  def build_version(version = 'nightly')
    puts "Building version #{version}"
    reset_nightly

    branch = "remotes/origin/KATELLO-#{version}"

    FileUtils.rmdir('docs/' + version)

    Dir.chdir(BUILD_DIR + '/' + version) do
      syscall("git checkout #{branch}")
    end

    Dir.chdir(BUILD_DIR + '/nightly') do
      set_config("version: #{version}")
      FileUtils.mkdir('docs/' + version)
      syscall("cp -rf ../#{version}/docs/* docs/#{version}")
      jekyll_build
      cleanup_config
    end

    copy_version(version)
  end

  private

  def reset_nightly
    Dir.chdir(BUILD_DIR + '/nightly') do
      syscall('git reset origin/master --hard')
    end
  end

  def copy_version(version)
    puts "Copying #{version}"

    FileUtils.cp_r("_build/nightly/_site/docs/#{version}/.", "docs/#{version}")
  end

  def jekyll_build
    syscall('jekyll build --config _config.yml,_config.build.yml')
  end

  def cleanup_config
    syscall('rm -f _config.build.yml')
  end

  def set_config(values)
    File.open('_config.build.yml', 'w') do |file|
      file.write(values)
    end
  end

  def syscall(*cmd)
    stdout, stderr, status = Open3.capture3(*cmd)
    if status.success?
      stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
    else
      puts stderr
      false
    end
  end

end


Deployer.new
