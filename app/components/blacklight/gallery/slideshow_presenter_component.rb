module Blacklight
  module Gallery
    # Displays the slideshow viewer.
    class SlideshowPresenterComponent < ViewComponent::Base
      def initialize(document_presenters:, view_config:, counter_offset:)
        @document_presenters = document_presenters
        @view_config = view_config
        @counter_offset = counter_offset
        super()
      end

      attr_accessor :document_presenters, :view_config, :counter_offset

      delegate :document_component, to: :view_config
    end
  end
end
