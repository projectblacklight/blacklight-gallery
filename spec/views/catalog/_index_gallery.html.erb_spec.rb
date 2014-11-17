require 'spec_helper'

describe "catalog/_index_gallery.html.erb", :type => :view do
  let(:blacklight_config) { Blacklight::Configuration.new }

  let(:document) { stub_model(::SolrDocument) }

  before do
    blacklight_config.view.gallery.partials = ['a', 'b']
    allow(view).to receive_messages(blacklight_config: blacklight_config)
    allow(view).to receive_messages(document: document)
    allow(view).to receive_messages(document_counter: 3, document_counter_with_offset: 3)
  end

  it "should have thumbnail and caption" do
    expect(view).to receive(:render_thumbnail_tag).with(document, {}, hash_including(:counter)).and_return('Thumbnail')
    expect(view).to receive(:render_document_partials).with(document, ['a', 'b'], document_counter: 3).and_return('Z')
    render
    expect(rendered).to have_selector '.thumbnail', text: 'Thumbnail'
    expect(rendered).to have_selector '.caption', text: 'Z'
  end
end
