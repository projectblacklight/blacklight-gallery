require 'spec_helper'

describe "Masonry view", :type => :feature do
  before { visit catalog_index_path :q => 'medicine', :view => 'masonry' }

  it "should display results in a galley view" do
    expect(page).to have_selector("#documents[data-behavior='masonry-gallery']")
    expect(page).to have_selector(".masonry.document .thumbnail")
    expect(page).to have_selector('.masonry.document .caption', text: "Strong Medicine speaks", visible: false)
  end
end
