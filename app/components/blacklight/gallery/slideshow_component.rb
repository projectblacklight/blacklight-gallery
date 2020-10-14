# frozen_string_literal: true

module Blacklight
  module Gallery
    class SlideshowComponent < Blacklight::DocumentComponent
      def count
        @document.response.total
      end

      def slideshow_tag
        @view_context.render_slideshow_tag(@document, { alt: '' })
      end

      def render_document_class(*args)
        @view_context.render_document_class(*args)
      end

      def presenter
        @presenter ||= @view_context.document_presenter(@document)
      end
    end
  end
end
