# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the icon for the add button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::AddCircleComponent.svg = '<svg>your SVG here</svg>'
      class AddCircleComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path fill="none" d="M0 0h24v24H0V0z"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm5 11h-4v4h-2v-4H7v-2h4V7h2v4h4v2z"/>
          </svg>
        SVG
      end
    end
  end
end