# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the gallery icon for the view type button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::GalleryComponent.svg = '<svg>your SVG here</svg>'
      class GalleryComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path fill="none" d="M0 0h24v24H0V0z"/><path d="M4 11h5V5H4v6zm0 7h5v-6H4v6zm6 0h5v-6h-5v6zm6 0h5v-6h-5v6zm-6-7h5V5h-5v6zm6-6v6h5V5h-5z"/>
          </svg>
        SVG
      end
    end
  end
end