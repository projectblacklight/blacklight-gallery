require 'blacklight'

module Blacklight
  module Gallery
    class Engine < Rails::Engine
      Blacklight::Configuration.default_values[:view].gallery.partials = [:index_header, :index]
      Blacklight::Configuration.default_values[:view].slideshow.partials = [:index]
    end
  end
end
