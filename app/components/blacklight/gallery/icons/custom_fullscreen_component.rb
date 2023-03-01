# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the icon for the fullscreen button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::CustomFullscreenComponent.svg = '<svg>your SVG here</svg>'
      class CustomFullscreenComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M7,14H5v5h5V17H7Zm7-9V7h3v3h2V5Z" /><path d="M22.517,1.524H1.736V22.37H22.517Zm-2,18.845H3.736V3.524H20.517Z" />
          </svg>
        SVG
      end
    end
  end
end