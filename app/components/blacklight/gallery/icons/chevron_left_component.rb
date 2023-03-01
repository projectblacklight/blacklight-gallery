# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the gallery icon for the view type button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::ChevronLeftComponent.svg = '<svg>your SVG here</svg>'
      class ChevronLeftComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path fill="none" d="M0 0h24v24H0V0z"/><path d="M15.41 7.41L14 6l-6 6 6 6 1.41-1.41L10.83 12l4.58-4.59z"/>
          </svg>
        SVG
      end
    end
  end
end