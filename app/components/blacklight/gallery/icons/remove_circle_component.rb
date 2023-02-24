# frozen_string_literal: true

module Blacklight
  module Gallery
    module Icons
      # This is the icon for the remove button.
      # You can override the default svg by setting:
      #   Blacklight::Gallery:Icons::RemoveCircleComponent.svg = '<svg>your SVG here</svg>'
      class RemoveCircleComponent < Blacklight::Icons::IconComponent
        self.svg = <<~SVG
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
            <path fill="none" d="M0 0h24v24H0V0z"/><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm5 11H7v-2h10v2z"/>
          </svg>
        SVG
      end
    end
  end
end