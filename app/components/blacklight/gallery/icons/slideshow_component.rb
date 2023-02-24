# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the gallery icon for the view type button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::SlideshowComponent.svg = '<svg>your SVG here</svg>'
      class SlideshowComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 25 24">
            <path d="m1 9v6h-1v-6zm6-3h12v13h-13v-13zm11 1h-11v11h11zm-13 0v11h-1v-11zm-2 1v9h-1v-9zm18-1v11h-1v-11zm2 1v8h-1v-8zm2 1v5h-1v-5z"/>
          </svg>
        SVG
      end
    end
  end
end