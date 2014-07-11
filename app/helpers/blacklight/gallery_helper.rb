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
