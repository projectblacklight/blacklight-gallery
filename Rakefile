require "bundler/gem_tasks"

APP_ROOT = File.dirname(__FILE__)

require 'rspec/core/rake_task'
require 'engine_cart/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :default => :ci

# Build with our opinionated defaults if none are provided.
rails_options = ENV.fetch('ENGINE_CART_RAILS_OPTIONS', '')
rails_options = "#{rails_options} -a propshaft" unless rails_options.match?(/-a\s|--asset-pipeline/)
rails_options = "#{rails_options} -j importmap" unless rails_options.match?(/-j\s|--javascript/)
rails_options = "#{rails_options} --css bootstrap" unless rails_options.match?(/--css\s|sprockets/)
ENV['ENGINE_CART_RAILS_OPTIONS'] = rails_options

desc "Load fixtures"
task :fixtures => ['engine_cart:generate'] do
  within_test_app do
      system "rake blacklight:index:seed RAILS_ENV=test"
      abort "Error running fixtures" unless $?.success?
  end
end

desc "Execute Continuous Integration build"
task :ci => ['engine_cart:generate'] do
  require 'solr_wrapper'
  SolrWrapper.wrap(port: '8983') do |solr|
    solr.with_collection(name: 'blacklight-core', dir: File.join(File.expand_path(File.dirname(__FILE__)), 'solr', 'conf')) do
      within_test_app do
        # Precompiles the assets
        `bin/rails spec:prepare`
      end

      Rake::Task['fixtures'].invoke
      Rake::Task['spec'].invoke
    end
  end
end

desc "Run Solr and Blacklight app for interactive development"
task :server do
  require 'solr_wrapper'
  SolrWrapper.wrap(port: '8983') do |solr|
    solr.with_collection(name: 'blacklight-core', dir: File.join(File.expand_path(File.dirname(__FILE__)), 'solr', 'conf')) do
      within_test_app do
        system "yarn build:css"
        system "rake blacklight:index:seed"
        system "bundle exec rails s"
      end
    end
  end
end
