require 'rails/generators'

module BlacklightGallery
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def assets
      copy_file "blacklight_gallery.css.scss", "app/assets/stylesheets/blacklight_gallery.css.scss"
      copy_file "blacklight_gallery.js", "app/assets/javascripts/blacklight_gallery.js"
    end
  end
end
