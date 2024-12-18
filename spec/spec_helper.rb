ENV["RAILS_ENV"] ||= 'test'

require 'engine_cart'
EngineCart.load_application!

require 'rspec/collection_matchers'
require 'rspec/its'
require 'rspec/rails'
require 'rspec/active_model/mocks'

require 'selenium-webdriver'

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.disable_animation = true

require 'blacklight'
require 'blacklight/gallery'

RSpec.configure do |c|
  c.infer_spec_type_from_file_location!
  c.include ViewComponent::TestHelpers, type: :component
end
