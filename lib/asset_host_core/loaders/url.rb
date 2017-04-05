require 'mime/types'
require 'net/http'
require 'cgi'

module AssetHostCore
  module Loaders
    class URL < Base
      SOURCE = "URL"

      #-----------

      def self.build_from_url(url)
        uri = URI.parse(url)
        return nil unless uri.is_a?(URI::HTTP)

        response  = Net::HTTP.get_response(uri)

        # Check that it's actually an image we're grabbing
        if response.content_type.match(/image/)
          self.new(url: url, id: url)
        else
          nil
        end
      end

      #----------

      def load
        filename = File.basename(@url)

        # build asset
        asset = Asset.new(
          :title    => filename,
          :url      => @url,
          :notes    => "Fetched from URL: #{@url}",
          :image    => image_file
        )

        asset.save!
        image_file.close(true)
        asset
      end

      #----------

      private

      def image_file
        @image_file ||= begin
          tempfile = Tempfile.new('ah-url', encoding: "ascii-8bit")
          open(@url) { |f| tempfile.write(f.read) }
          tempfile.rewind

          tempfile
        end
      end
    end
  end
end
