# frozen_string_literal: true

module Blacklight
  module Gallery
    class OpenseadragonEmbedComponent < Blacklight::Component
      attr_reader :document, :presenter, :classes

      def initialize(document:, presenter:, view_config: nil, classes: [], **kwargs)
        super

        @document = document
        @presenter = presenter
        @view_config = view_config
        @classes = classes
        @id_prefix = id_prefix
      end

      def image
        @image ||= document.to_openseadragon(view_config)
      end

      def count
        Array(image).length
      end

      def view_config
        @view_config || presenter.view_config
      end

      def render?
        !image.nil?
      end

      def osd_config
        {
          crossOriginPolicy: false,
          zoomInButton: "#{@id_prefix}-zoom-in",
          zoomOutButton: "#{@id_prefix}-zoom-out",
          homeButton: "#{@id_prefix}-home",
          fullPageButton: "#{@id_prefix}-full-page",
          nextButton: "#{@id_prefix}-next",
          previousButton: "#{@id_prefix}-previous"
        }
      end

      def osd_config_referencestrip
        {
          showReferenceStrip: true,
          sequenceMode: true,
          referenceStripScroll: 'vertical',
          referenceStripBackgroundColor: 'transparent'
        }
      end

      def id_prefix
        "osd-#{Blacklight::OpenseadragonHelper.mint_id}".to_param
      end
    end
  end
end
