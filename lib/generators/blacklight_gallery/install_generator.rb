require 'rails/generators'

module BlacklightGallery
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def assets
      copy_file "blacklight_gallery.css.scss", "app/assets/stylesheets/blacklight_gallery.css.scss"
      copy_file "blacklight_gallery.js", "app/assets/javascripts/blacklight_gallery.js"

      insert_into_file "app/assets/javascripts/application.js", after: '//= require blacklight/blacklight' do
        "\n//= require blacklight_gallery"
      end
    end

    def configuration
      inject_into_file 'app/controllers/catalog_controller.rb', after: "configure_blacklight do |config|" do
        "\n    config.view.gallery.partials = [:index_header, :index]" \
        "\n    # config.view.gallery.classes = 'row-cols-2 row-cols-md-3'" \
        "\n    config.view.masonry.partials = [:index]" \
        "\n    config.view.slideshow.partials = [:index]\n\n" \
        "\n    config.show.tile_source_field = :content_metadata_image_iiif_info_ssm" \
        "\n    config.show.partials.insert(1, :openseadragon)"
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
