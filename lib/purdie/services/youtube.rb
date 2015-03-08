require 'purdie'
require 'cgi'
require 'google/api_client'

module Purdie
  module Services
    class YouTube
      include Ingester

      def configure
        @matcher = 'youtube.com'
        @output_file = 'youtube.yaml'

        super
      end

      def get url
        client = Google::APIClient.new(
          key: ENV['YOUTUBE_API_KEY'],
          authorization: nil,
          application_name: 'purdie',
          application_version: Purdie::VERSION
        )

        youtube = client.discovered_api(
          ENV['YOUTUBE_API_SERVICE_NAME'],
          ENV['YOUTUBE_API_VERSION']
        )

        data = client.execute!(
          api_method: youtube.videos.list,
          parameters: {
            id: YouTube.get_id(url),
            part: 'status'
          }
        )
        JSON.parse data.body
      end

      def self.get_id url
        params = CGI.parse(URI.parse(url).query)
        params['v'].first
      end
    end
  end
end
