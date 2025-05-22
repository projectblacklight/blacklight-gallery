require 'spec_helper'

RSpec.describe 'Slideshow', js: true do
  it 'opens when one of the grid panes is clicked' do
    visit search_catalog_path(q: 'medicine', view: 'slideshow')

    find('.grid [data-slide-to="0"], .grid [data-bs-slide-to="0"]').click
    expect(page).to have_css('.slideshow-inner .item')
  end
end
