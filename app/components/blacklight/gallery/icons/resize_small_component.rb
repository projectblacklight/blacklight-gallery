# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the icon for the resize button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::ResizeSmallComponent.svg = '<svg>your SVG here</svg>'
      class ResizeSmallComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M5,16H8v3h2V14H5ZM16,8V5H14v5h5V8Z"/><path d="M22.517,1.524H1.736V22.37H22.517Zm-2,18.845H3.736V3.524H20.517Z"/>
          </svg>
        SVG
      end
    end
  end
end