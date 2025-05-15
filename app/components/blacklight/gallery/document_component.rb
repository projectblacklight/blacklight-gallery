# frozen_string_literal: true

module Blacklight
  module Gallery
    class DocumentComponent < Blacklight::DocumentComponent
      def before_render
        with_thumbnail(image_options: { class: 'img-thumbnail' }) unless thumbnail.present?
        super
      end

      def render_document_class(*args)
        @view_context.render_document_class(*args)
      end

      def caption_area_classes
        if params[:view] == 'masonry'
          %w[caption-area bg-dark text-white]
        else
          %w[caption-area]
        end
      end
    end
  end
end
