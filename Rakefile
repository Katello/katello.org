require 'json'
require 'open-uri'
require 'html/proofer'

namespace :test do
  task :travis do
    if (pr = ENV['TRAVIS_PULL_REQUEST']) && !pr.empty?
      puts "Testing PR #{pr}"

      details = JSON.load(open("https://api.github.com/repos/katello/Katello.org/pulls/#{pr}").read)
      target = details['base']['ref']
      clone_url = details['base']['repo']['clone_url']

      start = Dir.pwd
      sh "git clone #{clone_url} pr_test"
      Dir.chdir 'pr_test'
      sh "git checkout #{target}"
      sh "git fetch origin +refs/pull/#{pr}/merge"
      sh "git merge FETCH_HEAD"
      sh 'git checkout deploy'
      sh './deploy.rb'
      Dir.chdir start

      HTML::Proofer.new("./pr_test/public", :href_ignore => ['#'], :file_ignore => [/.*\/docs\/2.0.*/]).run
    else
      puts "No PR found. Testing local."
      Rake::Task['test:local'].invoke
    end
  end

  task :local do
    sh 'jekyll build'
    HTML::Proofer.new("./_site", :href_ignore => ['#'], :file_ignore => ['./_site/index.html']).run
  end
end
