require 'blacklight'

module Blacklight
  module Gallery
    class Engine < Rails::Engine
      Blacklight::Configuration.default_values[:document_index_view_types] << "gallery"
      Blacklight::Configuration.default_values[:gallery] ||= OpenStructWithHashAccess.new(:partials => [:index_header])

    end
  end
end
