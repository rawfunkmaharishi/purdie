require 'google/api_client'

module Purdie
  module Services
    class YouTube
      include Service

      API_SERVICE_NAME = 'youtube'
      API_VERSION = 'v3'

      def configure
        @api_service_name = 'youtube'
        @api_version = 'v3'
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
          @api_service_name,
          @api_version
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
        begin
          data = get_data Purdie.get_id(url), 'status,snippet'
          JSON.parse data.body
        rescue Google::APIClient::ClientError => ce
          raise Purdie::CredentialsException.new self, 'missing' if ce.message.match /Daily Limit for Unauthenticated Use Exceeded/
          raise Purdie::CredentialsException.new self, 'duff' if ce.message.match /Bad Request/
        end
      end

      def distill url
        video = get url
        results = {}

        results['title'] = video['items'][0]['snippet']['localized']['title']
        results['id'] = Purdie.get_id(url)

        results.attach_license self, video['items'][0]['status']['license']

        results
      end

      def self.resolve url
        query = CGI.parse(URI.parse(url).query).keys
        return [url] unless (query.include?('list') and not query.include?('index'))

        set = YouTube.client.execute!(
          api_method: YouTube.yt_service.playlist_items.list,
          parameters: {
            playlistId: 'PLuPLM2FI60-OIgFTc9YCrGgH5XWGT6znV',
            part: 'contentDetails',
            maxResults: 50
          }
        ).body

        ids = JSON.parse(set)['items'].map { |v| v['contentDetails']['videoId'] }

        ids.map { |id| "https://youtube.com/watch?v=#{id}"}
      end

      def self.client
        Google::APIClient.new(
          key: ENV['YOUTUBE_API_KEY'],
          authorization: nil,
          application_name: self.class.name.split('::').first,
          application_version: Purdie::VERSION
        )
      end

      def self.yt_service
        client.discovered_api(
          API_SERVICE_NAME,
          API_VERSION
        )
      end

      def self.matcher
        'youtube.com'
      end
    end
  end
end
