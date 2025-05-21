# frozen_string_literal: true

require 'rails/generators'

module BlacklightGallery
  # Add sample thumbnails to the test application
  class ThumbnailsGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def add_sample_thumbnails
      inject_into_file 'app/helpers/application_helper.rb', after: 'module ApplicationHelper' do
        "\n  def render_thumbnail(_document, _options)\n    image_tag('https://iiif-images.library.upenn.edu/"\
        "iiif/2/d3f5f564-76c9-4911-aa5a-141923718c1e%2Faccess/full/!200,200/0/default.jpg')\n  end"
      end

      inject_into_file 'app/controllers/catalog_controller.rb', after: 'configure_blacklight do |config|' do
        "\n    config.index.thumbnail_method = :render_thumbnail"
      end
    end
  end
end
