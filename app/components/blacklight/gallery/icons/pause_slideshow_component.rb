# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the gallery icon for the view type button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::PauseSlideshowComponent.svg = '<svg>your SVG here</svg>'
      class PauseSlideshowComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 14H9V8h2v8zm4 0h-2V8h2v8z"></path>
          </svg>
        SVG
      end
    end
  end
end