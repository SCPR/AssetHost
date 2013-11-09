require 'spec_helper'

describe AssetHostCore::Loaders::URL do
  describe '::build_from_url' do
    it 'returns a loader if the URL is an image' do
      FakeWeb.register_uri(:get, %r{imgur\.com},
        body: "raw image", content_type: "image/jpeg")

      loader = AssetHostCore::Loaders::URL.build_from_url("http://imgur.com/a/whatever.jpg")
      loader.should_not eq nil
    end

    it "returns nil if the URL is not an image" do
      FakeWeb.register_uri(:get, %r{news\.com},
        body: "Not an image!", content_type: "text/html")

      loader = AssetHostCore::Loaders::URL.build_from_url("http://news.com/whatever.html")
      loader.should eq nil
    end
  end

  describe '#load' do
    before :each do
      FakeWeb.register_uri(:get, %r{imgur\.com},
        body: load_image('fry.png'), content_type: "image/png")
    end

    it 'creates and returns an asset' do
      loader = AssetHostCore::Loaders::URL.build_from_url('http://imgur.com/a/whatever.jpg')
      asset = loader.load
      asset.persisted?.should eq true
      asset.image.file?.should eq true
    end

    it "sets the filename correctly" do
      loader = AssetHostCore::Loaders::URL.build_from_url('http://imgur.com/a/whatever.jpg')
      asset  = loader.load

      asset.title.should eq "whatever.jpg"
    end
  end
end
