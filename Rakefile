require 'json'
require 'open-uri'
require 'html/proofer'

namespace :test do
  task :travis do
    if (pr = ENV['TRAVIS_PULL_REQUEST']) && !pr.empty?
      sh 'git clone https://github.com/Katello/katello.org.git -b deploy deploy'

      Dir.chdir 'deploy' do
        sh "./deploy.rb --pr #{pr}"
      end

      HTML::Proofer.new("./deploy/public", :href_ignore => ['#'], :file_ignore => [/.*\/docs\/2.0.*/]).run
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
