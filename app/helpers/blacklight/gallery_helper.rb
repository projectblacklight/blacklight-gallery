module Blacklight
  module GalleryHelper
    def render_slideshow_tag(document, image_options = {}, url_options = {})
      if blacklight_config.view_config(document_index_view_type).slideshow_method
        method_name = blacklight_config.view_config(document_index_view_type).slideshow_method
        send(method_name, document, image_options)
      elsif blacklight_config.view_config(document_index_view_type).slideshow_field
        url = slideshow_image_url(document)

        image_tag url, image_options if url.present?
      elsif document_presenter(document).thumbnail.exists?
        document_presenter(document).thumbnail.thumbnail_tag(image_options, url_options.reverse_merge(suppress_link: true))
      end
    end

    def slideshow_image_url(document)
      if document.has? blacklight_config.view_config(document_index_view_type).slideshow_field
        document.first(blacklight_config.view_config(document_index_view_type).slideshow_field)
      end
    end
  end
end
