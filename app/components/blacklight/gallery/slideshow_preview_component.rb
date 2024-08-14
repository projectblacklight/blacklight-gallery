# frozen_string_literal: true

module Blacklight
  module Gallery
    class SlideshowPreviewComponent < Blacklight::DocumentComponent
      with_collection_parameter :document

      def initialize(document:, document_counter: nil, **args)
        super(document: document, document_counter: document_counter, **args)
        @document_counter = document_counter || @counter
      end

      def before_render
        populate_thumbnail_slot if thumbnail.blank?
        super
      end

      # populate the thumbnail slot with a value if one wasn't explicitly provided
      def populate_thumbnail_slot
        thumbnail_content = presenter.thumbnail.render({ alt: presenter.heading }) if presenter.thumbnail.exists?
        unless thumbnail_content.present?
          thumbnail_content = content_tag(
            :div,
            t(:missing_image, scope: %i[blacklight_gallery catalog grid_slideshow]),
            class: 'thumbnail thumbnail-placeholder'
          )
        end
        with_thumbnail(thumbnail_content)
      end

      def presenter
        @presenter ||= @view_context.document_presenter(@document)
      end

      def render_document_class(*args)
        @view_context.render_document_class(*args)
      end

      def link_to_document
        helpers.link_to_document(@document, thumbnail, class: 'thumbnail', data: data_attributes)
      end

      def data_attributes
        # 'context-href': nil is for Blacklight < 7.38, :context_href is for those after 7.38
        {
          'context-href': nil,
          context_href: nil,
          'slide-to': @document_counter,
          'bs-slide-to': @document_counter,
          toggle: "modal",
          'bs-toggle': "modal",
          target: "#slideshow-modal",
          'bs-target': "#slideshow-modal"
        }
      end
    end
  end
end
