require 'spec_helper'

describe "Slideshow view" do
  before { visit catalog_index_path :q => 'medicine', :view => 'slideshow' }

  it "should display results in a slideshow view" do
    expect(page).to have_selector("#documents.slideshow")
    expect(page).to have_selector("#slideshow .item.active")
    expect(page).to have_selector("#slideshow .carousel-caption", text: "Strong Medicine speaks")
  end
end

