require 'spec_helper'

describe "catalog/_document_masonry.html.erb", :type => :view do
  let(:blacklight_config) { Blacklight::Configuration.new }
  let(:documents) { [stub_model(::SolrDocument), stub_model(::SolrDocument)] }
  before do
    allow(view).to receive_messages(blacklight_config: blacklight_config)
    allow(view).to receive_messages(documents: documents)
    allow(view).to receive_messages(document_counter: 1)
    allow(view).to receive_messages(document_counter_with_offset: 1)
    allow(view).to receive_messages(render_document_partials: "Caption")
    allow(view).to receive_messages(render_thumbnail_tag: "Thumbnail")
    render
  end

  it 'should render a container div with a data attribute to initiate the masonry plugin' do
    expect(rendered).to have_css('#documents[data-behavior="masonry-gallery"]')
  end

  it 'should render a .masonry.document div for each document' do
    expect(rendered).to have_css('.masonry.document', count: 2)
  end

  it 'should render the thumbnail' do
    expect(rendered).to have_css('.thumbnail', text: 'Thumbnail')
  end

  it 'should render the caption' do
    expect(rendered).to have_css('.caption', text: 'Caption')
  end
end
