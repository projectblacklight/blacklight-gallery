ENV["RAILS_ENV"] ||= 'test'

require 'engine_cart'
EngineCart.load_application!

require 'rspec/collection_matchers'
require 'rspec/its'
require 'rspec/rails'
require 'rspec/active_model/mocks'
require 'view_component_v2_test_helpers'

require 'selenium-webdriver'

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.disable_animation = true

require 'blacklight'
require 'blacklight/gallery'

RSpec.configure do |c|
  c.infer_spec_type_from_file_location!
  c.include ViewComponent::TestHelpers, type: :component
  view_component_version = Gem.loaded_specs['view_component'].version
  VIEW_COMPONENT_VERSION = view_component_version.segments.first
  if VIEW_COMPONENT_VERSION < 3
    c.include ViewComponentV2TestHelpers, type: :component
  end
end
