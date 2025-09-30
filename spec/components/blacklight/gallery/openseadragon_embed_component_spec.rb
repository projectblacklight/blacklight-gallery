# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Blacklight::Gallery::OpenseadragonEmbedComponent, type: :component do
  subject(:component) do
    described_class.new(
      presenter: presenter,
      **attr
    )
  end

  let(:attr) { {} }
  let(:view_context) { vc_test_controller.view_context }
  let(:render) do
    component.render_in(view_context)
  end

  let(:rendered) do
    Capybara::Node::Simple.new(render)
  end

  let(:document) do
    SolrDocument.new(
      id: 'x'
    )
  end

  let(:presenter) { Blacklight::IndexPresenter.new(document, view_context, blacklight_config) }

  before do
    allow(view_context).to receive(:current_search_session).and_return(nil)
    allow(view_context).to receive(:search_session).and_return({})
    allow(view_context).to receive(:blacklight_config).and_return(blacklight_config)
  end

  describe 'openseadragon viewer' do
    let(:blacklight_config) do
      Blacklight::Configuration.new.tap do |config|
        config.index.slideshow_method = :xyz
        if Blacklight::VERSION > '8'
          config.track_search_session.storage = false
        else
          config.track_search_session = false
        end
      end
    end
    it 'uses a single @id_prefix to generate unique control ids' do
      expect(component.osd_config[:zoomInButton]).to include(component.instance_variable_get(:@id_prefix))
      expect(component.osd_config[:zoomOutButton]).to include(component.instance_variable_get(:@id_prefix))
      expect(component.osd_config[:homeButton]).to include(component.instance_variable_get(:@id_prefix))
      expect(component.osd_config[:fullPageButton]).to include(component.instance_variable_get(:@id_prefix))
      expect(component.osd_config[:nextButton]).to include(component.instance_variable_get(:@id_prefix))
      expect(component.osd_config[:previousButton]).to include(component.instance_variable_get(:@id_prefix))
    end
  end
end
