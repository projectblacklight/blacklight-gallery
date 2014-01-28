source 'https://rubygems.org'

# Specify your gem's dependencies in blacklight-gallery.gemspec
gemspec

group :test do
  gem "bootstrap-sass"
  gem 'turbolinks'
  gem 'sass-rails'
end

if File.exists?('spec/test_app_templates/Gemfile.extra')
  eval File.read('spec/test_app_templates/Gemfile.extra'), nil, 'spec/test_app_templates/Gemfile.extra'
end