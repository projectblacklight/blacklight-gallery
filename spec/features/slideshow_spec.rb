require 'spec_helper'

RSpec.describe 'Slideshow', js: true do
  it 'opens when one of the grid panes is clicked' do
    visit search_catalog_path(q: 'medicine', view: 'slideshow')

    find('.grid [data-bs-slide-to="0"]').click
    expect(page).to have_css('.slideshow-inner .item')
  end

  it 'opens to the slide for the clicked thumbnail and can advance' do
    visit search_catalog_path(q: '', search_field: 'all_fields', view: 'slideshow')

    find('.grid [data-bs-slide-to="3"]').click
    within '#slideshow-modal' do
      expect(page).to have_css('.carousel-item.active', text: '4 of')
      find('.carousel-control-next').click
      expect(page).to have_css('.carousel-item.active', text: '5 of')
    end
  end

  it 'opens to the slide for the clicked thumbnail on a later page of results' do
    visit search_catalog_path(q: '', search_field: 'all_fields', view: 'slideshow', page: 2)

    find('.grid [data-bs-slide-to="3"]').click
    within '#slideshow-modal' do
      expect(page).to have_css('.carousel-item.active', text: '14 of')
      find('.carousel-control-prev').click
      expect(page).to have_css('.carousel-item.active', text: '13 of')
    end
  end
end
