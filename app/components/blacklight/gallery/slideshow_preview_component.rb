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
        thumbnail(presenter.thumbnail.render({ alt: presenter.heading })) if thumbnail.blank? && presenter.thumbnail.exists?
        thumbnail(content_tag(:div, t('.missing_image', scope: [:blacklight_gallery]), class: 'thumbnail thumbnail-placeholder')) if thumbnail.blank?
        super
      end

      def presenter
        @presenter ||= @view_context.document_presenter(@document)
      end

      def render_document_class(*args)
        @view_context.render_document_class(*args)
      end
    end
  end
end
