ENV["RAILS_ENV"] ||= 'test'

require 'engine_cart'
EngineCart.load_application!

require 'rspec/collection_matchers'
require 'rspec/its'
require 'rspec/rails'
require 'rspec/active_model/mocks'

require 'selenium-webdriver'
require 'chromedriver-helper'

Capybara.javascript_driver = :headless_chrome

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu no-sandbox] }
  )

  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 desired_capabilities: capabilities)
end

require 'blacklight'
require 'blacklight/gallery'

RSpec.configure do |c|
  c.infer_spec_type_from_file_location!
  c.full_backtrace = true
  #onfig.assets.precompile += %w(spotlight/default_thumbnail.jpg spotlight/default_browse_thumbnail.jpg)
end
