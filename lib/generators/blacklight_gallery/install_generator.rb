require 'rails/generators'

module BlacklightGallery
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def assets
      copy_file "blacklight_gallery.css.scss", "app/assets/stylesheets/blacklight_gallery.css.scss"
      copy_file "blacklight_gallery.js", "app/assets/javascripts/blacklight_gallery.js"
    end

    def configuration
      inject_into_file 'app/controllers/catalog_controller.rb', after: "configure_blacklight do |config|" do
        <<-EOF
          config.view.gallery.partials = [:index_header, :index]
          config.view.masonry.partials = [:index]
          config.view.slideshow.partials = [:index]

          config.show.tile_source_field = :content_metadata_image_iiif_info_ssm
          config.show.partials.insert(1, :openseadragon)
        EOF
      end
    end

    def add_model_mixin
      inject_into_file 'app/models/solr_document.rb', after: "include Blacklight::Solr::Document" do
       "\n  include Blacklight::Gallery::OpenseadragonSolrDocument\n"
      end
    end

    def add_openseadragon
      generate 'openseadragon:install'
    end
  end
end
