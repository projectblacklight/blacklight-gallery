module Blacklight
  module GalleryHelper
    def render_gallery_collection documents
      index = -1
      documents.map do |object|
        index += 1
        template = gallery_wrapper_template(object)
        template.render(self, {document: object, document_counter: index}) if template

      end.join().html_safe
    end

    def render_slideshow_tag(document, image_options = {}, url_options = {})
      if blacklight_config.view_config(document_index_view_type).slideshow_method
        method_name = blacklight_config.view_config(document_index_view_type).slideshow_method
        send(method_name, document, image_options)
      elsif blacklight_config.view_config(document_index_view_type).slideshow_field
        url = slideshow_image_url(document)

        image_tag url, image_options if url.present?
      elsif has_thumbnail?(document)
        document_presenter(document).thumbnail.thumbnail_tag(image_options, url_options.reverse_merge(suppress_link: true))
      end
    end

    def slideshow_image_url(document)
      if document.has? blacklight_config.view_config(document_index_view_type).slideshow_field
        document.first(blacklight_config.view_config(document_index_view_type).slideshow_field)
      end
    end

    def gallery_wrapper_template(object)
      format = document_partial_name(object, nil)
      ['index_gallery_%{format}_wrapper', 'index_gallery'].each do |str|
        partial = str % { format: format }
        logger.debug "Looking for gallery document wrapper #{partial}"
        template = lookup_context.find_all(partial, lookup_context.prefixes, true, [:document, :document_counter], {}).first
        return template if template
      end
    end
  end
end
