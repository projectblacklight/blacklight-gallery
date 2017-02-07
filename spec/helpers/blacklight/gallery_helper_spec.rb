require 'spec_helper'

describe Blacklight::GalleryHelper, :type => :helper do
  before do
    allow(helper).to receive(:blacklight_configuration_context).and_return(double(evaluate_if_unless_configuration: true))
  end
  describe "#render_gallery_collection" do
    let(:template) { double }
    before do
      allow(template).to receive(:render).and_return("hello ")
      allow(helper).to receive(:gallery_wrapper_template).and_return(template)
    end
    let(:documents) { [ double, double] }
    subject { helper.render_gallery_collection documents}

    it { is_expected.to eq 'hello hello ' }
  end

  describe "#gallery_wrapper_template" do
    before do
      allow(helper).to receive(:blacklight_config).and_return(CatalogController.blacklight_config)
      helper.lookup_context.prefixes << "catalog"
    end
    
    subject { helper.gallery_wrapper_template SolrDocument.new }

    it "should be the default template" do
       expect(subject.virtual_path).to eq 'catalog/_index_gallery'
    end
  end
  
  describe "render_slideshow_tag" do
    let(:document) { instance_double(SolrDocument) }

    it "calls the provided slideshow method" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_method => :xyz) ))
      expect(helper).to receive_messages(:xyz => "some-slideshow")
      expect(helper.render_slideshow_tag(document)).to eq 'some-slideshow'
    end

    it "creates an image tag from the given field" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_field => :xyz) ))

      allow(document).to receive(:has?).with(:xyz).and_return(true)
      allow(document).to receive(:first).with(:xyz).and_return("http://example.com/some.jpg")
      expect(helper.render_slideshow_tag(document)).to match /img/
    end

    it "does not link to the document if the url options are false" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_method => :xyz) ))
      allow(helper).to receive_messages(:xyz => "some-slideshow")

      result = helper.render_slideshow_tag document, {}, false
      expect(result).to eq "some-slideshow"
    end

    it "does not link to the document if the url options have :suppress_link" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_method => :xyz) ))
      allow(helper).to receive_messages(:xyz => "some-slideshow")

      result = helper.render_slideshow_tag document, {}, suppress_link: true
      expect(result).to eq "some-slideshow"
    end


    it "returns nil if no slideshow is available" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new() ))
      expect(helper.render_slideshow_tag document).to be_nil
    end

    it "returns nil if no slideshow is returned from the slideshow method" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_method => :xyz) ))
      allow(helper).to receive_messages(:xyz => nil)

      expect(helper.render_slideshow_tag document).to be_nil
    end

    it "returns nil if no slideshow is in the document" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_field => :xyz) ))

      allow(document).to receive(:has?).with(:xyz).and_return(false)

      expect(helper.render_slideshow_tag document).to be_nil
    end
    
    it "falls back to a thumbnail" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:thumbnail_method => :xyz) ))
      allow(helper).to receive(:xyz).and_return('thumbnail-image')

      expect(helper.render_slideshow_tag document).to eq 'thumbnail-image'
    end
  end

  describe "slideshow_url" do
    it "pulls the configured slideshow field out of the document" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_field => :xyz) ))
      document = instance_double(SolrDocument)
      allow(document).to receive(:has?).with(:xyz).and_return(true)
      allow(document).to receive(:first).with(:xyz).and_return("asdf")
      expect(helper.slideshow_image_url document).to eq("asdf")
    end

    it "returns nil if the slideshow field doesn't exist" do
      allow(helper).to receive_messages(:blacklight_config => Blacklight::Configuration.new(:index => Blacklight::OpenStructWithHashAccess.new(:slideshow_field => :xyz) ))
      document = instance_double(SolrDocument)
      allow(document).to receive(:has?).with(:xyz).and_return(false)
      expect(helper.slideshow_image_url document).to be_nil
    end
  end
end
