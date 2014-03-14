source 'https://rubygems.org'

# Specify your gem's dependencies in blacklight-gallery.gemspec
gemspec

# If we don't specify 2.11.0 we'll end up with sprockets 2.12.0 in the main 
# Gemfile.lock but since sass-rails gets generated (rails new) into the test app
# it'll want sprockets 2.11.0 and we'll have a conflict
gem 'sprockets', '2.11.0'

# If we don't specify 3.2.15 we'll end up with sass 3.3.2 in the main 
# Gemfile.lock but since sass-rails gets generated (rails new) into the test app
# it'll want sass 3.2.0 and we'll have a conflict
gem 'sass', '~> 3.2.0'

group :test do
  gem "bootstrap-sass"
  gem 'turbolinks'
  gem 'sass-rails'
end

gem 'activerecord-jdbcsqlite3-adapter', :platform => :jruby

if File.exists?('spec/test_app_templates/Gemfile.extra')
  eval File.read('spec/test_app_templates/Gemfile.extra'), nil, 'spec/test_app_templates/Gemfile.extra'
end
