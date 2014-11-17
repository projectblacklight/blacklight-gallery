require 'spec_helper'

describe "Gallery view", :type => :feature do
  before { visit catalog_index_path :q => 'medicine', :view => 'gallery' }

  it "should display results in a galley view" do
    expect(page).to have_selector("#documents.gallery")
    expect(page).to have_selector(".gallery .document .thumbnail .caption")
    expect(page).to have_content("Strong Medicine speaks")
  end
end