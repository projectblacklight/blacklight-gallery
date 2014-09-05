ENV["RAILS_ENV"] ||= 'test'

require 'blacklight'
require 'blacklight/gallery'

require 'engine_cart'
EngineCart.load_application!

require 'rspec/rails'
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.infer_spec_type_from_file_location!
  
end

