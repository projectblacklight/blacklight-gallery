require 'spec_helper'

RSpec.describe "catalog/_document_slideshow", :type => :view do
  let(:blacklight_config) do
    Blacklight::Configuration.new do |config|
      if Blacklight::VERSION > '8'
        config.track_search_session.storage = false
      else
        config.track_search_session = false
      end
    end
  end

  let(:document) { stub_model(::SolrDocument) }
  let(:view_config) { Blacklight::Configuration::ViewConfig.new(document_component: Blacklight::Gallery::SlideshowComponent) }

  before do
    allow(view).to receive_messages(
      blacklight_config: blacklight_config,
      documents: [document],
      document_index_view_type: 'slideshow',
      document_counter_with_offset: 1
    )
    allow(view).to receive(:current_search_session).and_return(nil)
    allow(view).to receive(:search_session).and_return({})
    allow(view).to receive(:search_state).and_return(Blacklight::SearchState.new({}, blacklight_config))
    @response = instance_double(Blacklight::Solr::Response, start: 0)
  end

  it 'has a modal' do
    render 'catalog/document_slideshow', view_config: view_config
    expect(rendered).to have_selector '#slideshow-modal'
    expect(rendered).to have_selector '[data-slide="prev"]'
    expect(rendered).to have_selector '[data-slide="next"]'
    expect(rendered).to have_selector '[data-slide-to="0"][data-toggle="modal"][data-target="#slideshow-modal"]'
  end
end
