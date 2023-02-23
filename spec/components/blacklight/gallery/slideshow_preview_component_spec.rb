# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Blacklight::Gallery::SlideshowPreviewComponent, type: :component do
  subject(:component) { described_class.new(document: presenter, document_counter: 5, **attr) }

  let(:attr) { {} }
  let(:view_context) { controller.view_context }
  let(:render) do
    component.render_in(view_context)
  end

  let(:rendered) do
    Capybara::Node::Simple.new(render)
  end

  let(:blacklight_config) { Blacklight::Configuration.new }
  let(:presenter) { Blacklight::IndexPresenter.new(document, view_context, blacklight_config) }

  before do
    allow(view_context).to receive(:blacklight_config).and_return(blacklight_config)
    allow(view_context).to receive(:current_search_session).and_return(nil)
    allow(view_context).to receive(:search_session).and_return({})

    # dumb hack to get our stubbing into the thumbnail component
    allow(controller).to receive(:view_context).and_return(view_context)
  end

  let(:blacklight_config) do
    Blacklight::Configuration.new.tap do |config|
      config.index.thumbnail_field = 'thumbnail_path_ss'
      if Blacklight::VERSION > '8'
        config.track_search_session.storage = false
      else
        config.track_search_session = false
      end
    end
  end

  describe 'default thumbnail' do
    let(:document) { SolrDocument.new(id: 'abc', thumbnail_path_ss: 'http://example.com/image.jpg') }

    it 'renders the thumbnail' do
      expect(rendered).to have_selector '.thumbnail img[@src="http://example.com/image.jpg"]'
    end

    context 'when the presenter returns nothing' do
      let(:document) { SolrDocument.new(id: 'abc') }

      subject { rendered }
      it { is_expected.to have_selector '.thumbnail-placeholder', text: 'Missing' }
    end
  end
end
