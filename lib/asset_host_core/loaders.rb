require "asset_host_core/loaders/base"
require "asset_host_core/loaders/asset_host"
require "asset_host_core/loaders/youtube"
require "asset_host_core/loaders/vimeo"
require "asset_host_core/loaders/brightcove"
require "asset_host_core/loaders/flickr"
require "asset_host_core/loaders/url"

module AssetHostCore
  module Loaders

    MODULES = [
      AssetHost,
      YouTube,
      Flickr,
      Brightcove,
      URL
    ]

    class << self
      def load(url)
        loader = nil
        MODULES.find { |klass| loader = klass.try_url(url) }
        loader.try(:load)
      end
      

      def classes
        puts "Classes: " + MODULES.to_s
      end
    end
  end
end
