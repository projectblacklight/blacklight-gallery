require 'blacklight'

module Blacklight
  module Gallery
    class Engine < Rails::Engine
      Blacklight::Configuration.default_values[:view].gallery.partials = [:index_header, :index]
    end
  end
end
