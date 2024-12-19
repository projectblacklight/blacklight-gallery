require 'blacklight'

module Blacklight
  module Gallery
    class Engine < Rails::Engine
      initializer 'blacklight_gallery.importmap', before: 'importmap' do |app|
        app.config.assets.paths << Engine.root.join("app/javascript")
        app.config.importmap.paths << Engine.root.join('config/importmap.rb') if app.config.respond_to?(:importmap)
      end
    end
  end
end
