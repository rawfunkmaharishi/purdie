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

      def client
        @client ||= Google::APIClient.new(
            key: ENV['YOUTUBE_API_KEY'],
            authorization: nil,
            application_name: self.class.name.split('::').first,
            application_version: Purdie::VERSION
          )
      end

      def yt_service
        @yt_service ||= client.discovered_api(
          ENV['YOUTUBE_API_SERVICE_NAME'],
          ENV['YOUTUBE_API_VERSION']
        )
      end

      def get_data id, part
        client.execute!(
          api_method: yt_service.videos.list,
          parameters: {
            id: id,
            part: part
          }
        )
      end

      def get url
        data = get_data YouTube.get_id(url), 'status,snippet'
        JSON.parse data.body
      end

      def distill url
        video = get url
        results = {}
      #  require 'pry'
      #  binding.pry

        results['title'] = video['items'][0]['snippet']['localized']['title']
        results['id'] = YouTube.get_id(url)
        results['license'] = @config['license_lookups'][video['items'][0]['status']['license']]['full_name']
        results['license_url'] = @config['license_lookups'][video['items'][0]['status']['license']]['url']

        results
      end

      def self.get_id url
        params = CGI.parse(URI.parse(url).query)
        params['v'].first
      end
    end
  end
end
