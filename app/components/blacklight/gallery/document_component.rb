# frozen_string_literal: true

module Blacklight
  module Gallery
    class DocumentComponent < Blacklight::DocumentComponent
      def before_render
        with_thumbnail(image_options: { class: 'img-thumbnail' }) unless thumbnail.present?
        super
      end
    end
  end
end
