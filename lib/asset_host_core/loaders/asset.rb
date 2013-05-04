module AssetHostCore
  module Loaders
    class Asset < Base
      
      def self.valid?(url)
        if url =~ /#{Rails.application.config.assethost.server}#{AssetHostCore::Engine.mounted_path}\/api\/assets\/(\d+)\/?/
          return self.new($~[1])
        elsif url =~ /#{Rails.application.config.assethost.server}#{AssetHostCore::Engine.mounted_path}\/i\/[^\/]+\/(\d+)-/
          return self.new($~[1])
        else  
          return nil
        end
      end
      
      def initialize(id)
        @source = "Asset"
        @id = id
      end
      
      def load
        AssetHostCore::Asset.find_by_id(@id)
      end
    end
  end
end
