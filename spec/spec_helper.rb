ENV["RAILS_ENV"] ||= 'test'

require 'engine_cart'
EngineCart.load_application!

require 'rspec/collection_matchers'
require 'rspec/its'
require 'rspec/rails'
require 'rspec/active_model/mocks'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

require 'blacklight'
require 'blacklight/gallery'

RSpec.configure do |c|
  c.infer_spec_type_from_file_location!
end

