require 'net/http'
require 'cgi'
require 'mime/types'

module AssetHostCore
  module Loaders
    class Flickr < Base
      SOURCE = "Flickr"

      def self.build_from_url(url)
        return nil if Rails.application.secrets.flickr_api_key.blank?

        matches = [
          %r{flickr\.com/photos/[\w@]+/(?<id>\d+)},
          %r{staticflickr\.com/\d+/(?<id>\d+)_[\w\d]+}
        ]

        match = nil

        if matches.find { |m| match = url.match(m) }
          self.new(url: url, id: match[:id])
        else
          nil
        end
      end

      #----------

      def load
        return nil if Rails.application.secrets.flickr_api_key.blank?

        flickr = MiniFlickr.new

        # we're going to try and go get it from flickr
        photo = flickr.call('flickr.photos.getInfo', photo_id: @id)["photo"]
        return nil if !photo

        sizes     = flickr.call('flickr.photos.getSizes', photo_id: @id)["sizes"]["size"]
        licenses  = flickr.call('flickr.photos.licenses.getInfo')

        @image_url = sizes[-1]["source"]

        # Load the image first so that the image EXIF data doesn't
        # override the data from the Flickr API.
        asset = Asset.new(
          # :image         => image_file,
          :file          => image_file,
          :title         => photo["title"]["_content"],
          :caption       => photo["description"]["_content"],
          :owner         => photo['owner']['realname'] || photo['owner']["username"],
          :image_taken   => photo["dates"]["taken"],
          :url           => photo['urls']['url'][0]['_content']
        )

        # look up licenses
        if license = licenses["licenses"]["license"].find { |l| l['id'] == photo['license'] }
          asset.notes = [ license['name'], license['url'] ].join(" : ")
        end

        # save Asset
        asset.save!
        image_file.close(true)
        asset
      end


      #----------

      private

      def image_file
        # @image_file ||= begin
        #   tempfile = Tempfile.new('ah-flickr', encoding: "ascii-8bit")
        #   open(@image_url) { |f| tempfile.write(f.read) }
        #   tempfile.rewind

        #   tempfile
        # end
        @image_file ||= open(@image_url)
      end
    end


    class MiniFlickr
      attr :api_key

      def user
        USERID
      end

      def call(method, params = {})
        parameters = params.dup

        parameters[:api_key]          = Rails.application.secrets.flickr_api_key
        parameters[:method]           = method
        parameters[:format]           = "json"
        parameters[:nojsoncallback]   = 1

        response = http.get(path_for_params(parameters))

        # return an object parsed from the JSON
        ActiveSupport::JSON.decode(response.body)
      end


      private

      def path_for_params(params)
        query_string = "?" + params.inject([]) { |qs, pair| qs << "#{CGI.escape(pair[0].to_s)}=#{CGI.escape(pair[1].to_s)}"; qs }.join("&")
        "/services/rest/" + query_string
      end

      def http
        @http ||= Net::HTTP.new("api.flickr.com", 80)
      end
    end
  end
end
