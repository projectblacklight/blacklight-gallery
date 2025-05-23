require 'rails/generators'

module BlacklightGallery
  class Install < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def configuration
      inject_into_file 'app/controllers/catalog_controller.rb', after: "configure_blacklight do |config|" do
        "\n    config.view.gallery(document_component: Blacklight::Gallery::DocumentComponent, icon: Blacklight::Gallery::Icons::GalleryComponent)" \
        "\n    config.view.masonry(document_component: Blacklight::Gallery::DocumentComponent, icon: Blacklight::Gallery::Icons::MasonryComponent)" \
        "\n    config.view.slideshow(document_component: Blacklight::Gallery::SlideshowComponent, icon: Blacklight::Gallery::Icons::SlideshowComponent)" \
        "\n    config.show.tile_source_field = :content_metadata_image_iiif_info_ssm" \
        "\n    config.show.partials ||= []" \
        "\n    config.show.partials.insert(1, :openseadragon)"
      end
    end

    def add_model_mixin
      inject_into_file 'app/models/solr_document.rb', after: "include Blacklight::Solr::Document" do
       "\n  include Blacklight::Gallery::OpenseadragonSolrDocument\n"
      end
    end

    def uncomment_thumbnail_config
      uncomment_lines 'app/controllers/catalog_controller.rb', /config\.index\.thumbnail_field.*$/
    end

    def add_openseadragon
      gem "openseadragon", "~> 1.0"
      Bundler.with_unbundled_env { run 'bundle install' }
      generate 'openseadragon:install'
    end

    def add_javascript
      if defined?(Importmap)
        say 'Installing assets for use with Importmaps', :green
        append_to_file 'config/importmap.rb', "pin \"jquery\", to: \"https://code.jquery.com/jquery-3.7.1.min.js\"\n"

        append_to_file 'app/javascript/application.js', after: %r{import Blacklight .*$} do
          <<~CONTENT

            import 'jquery'
            import 'blacklight-gallery'
          CONTENT
        end

        # Append plugin initialization code to main application.js file
        append_to_file 'app/javascript/application.js' do
          <<~CONTENT
            Blacklight.onLoad(function() {
              $('.documents-masonry').BlacklightMasonry();
              $('.documents-slideshow').slideshow();
            });
          CONTENT
        end
      end
    end

    def add_stylesheet
      # Indicates cssbundling-rails with bootstrap usage.
      if File.exist? 'app/assets/stylesheets/application.bootstrap.scss'
        append_to_file 'app/assets/stylesheets/application.bootstrap.scss' do
          <<~CONTENT
            @import url('blacklight_gallery/gallery.css');
            @import url('blacklight_gallery/masonry.css');
            @import url('blacklight_gallery/osd_viewer.css');
            @import url('blacklight_gallery/slideshow.css');
          CONTENT
        end
      else
        append_to_file 'app/assets/stylesheets/application.css' do
          <<~CONTENT
              @import url('blacklight_gallery/gallery.css');
              @import url('blacklight_gallery/masonry.css');
              @import url('blacklight_gallery/osd_viewer.css');
              @import url('blacklight_gallery/slideshow.css');
          CONTENT
        end
      end
    end

    def add_sprockets_support
      return unless defined?(Sprockets)

      append_to_file 'app/assets/config/manifest.js', "\n//= link blacklight_gallery/manifest.js\n"

      insert_into_file "app/assets/javascripts/application.js", after: '//= require blacklight/blacklight' do
        "\n//= require blacklight_gallery/blacklight-gallery"
      end

      insert_into_file "app/assets/javascripts/application.js" do
        <<~CONTENT
            Blacklight.onLoad(function() {
              $('.documents-masonry').BlacklightMasonry();
              $('.documents-slideshow').slideshow();
            });
          CONTENT
      end
    end
  end
end
