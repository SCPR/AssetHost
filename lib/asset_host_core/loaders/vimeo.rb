module AssetHostCore
  module Loaders
    class Vimeo < Base
      SOURCE = "Vimeo"

      #----------------

      def self.build_from_url(url)
        # Don't need a key just to read from the public API
        url.match(/vimeo\.com\/(?<id>\d+)/i) do |m|
          self.new(url: url, id: m[:id])
        end
      end

      #----------------

      def fetch_data
        connection.get do |request|
          request.url "video/#{@id}.json"
        end
      end


      private

      def connection
        @connection ||= begin
          Faraday.new('http://vimeo.com/api/v2') do |conn|
            conn.response :json
            conn.adapter Faraday.default_adapter
          end
        end
      end
    end
  end
end
