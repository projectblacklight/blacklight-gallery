require 'spec_helper'

describe "catalog/_document_slideshow.html.erb", :type => :view do
  let(:blacklight_config) { Blacklight::Configuration.new }

  let(:document) { stub_model(::SolrDocument) }

  before do
    allow(view).to receive_messages(blacklight_config: blacklight_config)
    allow(view).to receive_messages(documents: [document])
  end

  it "should have a edit tag form" do
    render
    expect(rendered).to have_selector '#slideshow-modal'
    expect(rendered).to have_selector '[data-slide="prev"]'
    expect(rendered).to have_selector '[data-slide="next"]'
    expect(rendered).to have_selector '[data-slide-to="0"][data-toggle="modal"][data-target="#slideshow-modal"]'
  end
end
