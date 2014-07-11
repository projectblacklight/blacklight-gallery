require 'spec_helper'

describe Blacklight::GalleryHelper do
  describe "#render_gallery_collection" do
    let(:template) { double }
    before do
      allow(template).to receive(:render).and_return("hello ")
      allow(helper).to receive(:gallery_wrapper_template).and_return(template)
    end
    let(:documents) { [ double, double] }
    subject { helper.render_gallery_collection documents}

    it { should eq 'hello hello ' }
  end

  describe "#gallery_wrapper_template" do
    before do
      helper.stub(:blacklight_config).and_return(CatalogController.blacklight_config)
      helper.lookup_context.prefixes << "catalog"
    end
    
    subject { helper.gallery_wrapper_template SolrDocument.new }

    it "should be the default template" do
       expect(subject.virtual_path).to eq 'catalog/_index_gallery'
    end
  end
end
