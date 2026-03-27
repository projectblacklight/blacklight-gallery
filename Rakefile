require 'bundler/gem_tasks'

APP_ROOT = File.dirname(__FILE__)

require 'rspec/core/rake_task'
require 'engine_cart/rake_task'
require 'open3'

def system_with_error_handling(*args)
  Open3.popen3(*args) do |_stdin, stdout, stderr, thread|
    puts stdout.read
    raise "Unable to run #{args.inspect}: #{stderr.read}" unless thread.value.success?
  end
end

def with_solr(&block)
  # We're being invoked by the app entrypoint script and solr is already up via docker compose
  if ENV['SOLR_ENV'] == 'docker-compose'
    yield
  elsif system('docker compose version')
    # We're not running `docker compose up' but still want to use a docker instance of solr.
    begin
      puts 'Starting Solr'
      system_with_error_handling 'docker compose up -d solr'
      yield
    ensure
      puts 'Stopping Solr'
      system_with_error_handling 'docker compose stop solr'
    end
  else
    SolrWrapper.wrap do |solr|
      solr.with_collection(&block)
    end
  end
end

RSpec::Core::RakeTask.new(:spec)

task default: :ci

# Build with our opinionated defaults if none are provided.
rails_options = ENV.fetch('ENGINE_CART_RAILS_OPTIONS', '')
rails_options = "#{rails_options} -a propshaft" unless rails_options.match?(/-a\s|--asset-pipeline/)
rails_options = "#{rails_options} -j importmap" unless rails_options.match?(/-j\s|--javascript/)
ENV['ENGINE_CART_RAILS_OPTIONS'] = rails_options

desc 'Load fixtures'
task fixtures: ['engine_cart:generate'] do
  within_test_app do
    system 'rake blacklight:index:seed RAILS_ENV=test'
    abort 'Error running fixtures' unless $?.success?
  end
end

desc 'Execute Continuous Integration build'
task :ci do
  with_solr do
    Rake::Task['fixtures'].invoke
    within_test_app do
      # Precompiles the assets
      `bin/rails spec:prepare`
    end
    Rake::Task['spec'].invoke
  end
end

desc 'Run Solr and Blacklight for interactive development'
task :server do
  with_solr do
    Rake::Task['fixtures'].invoke
    within_test_app do
      # Set `FILE` to the local fixture so we get thumbnails
      ENV['FILE'] = File.join(__dir__, 'spec', 'fixtures', 'sample_solr_documents.yml')
      system 'rake blacklight:index:seed'
      ENV.delete('FILE')

      system 'yarn build:css'
      system 'bundle exec rails s'
    end
  end
end
