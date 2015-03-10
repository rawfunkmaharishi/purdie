require 'purdie'

module Purdie
  module Services
    class Vimeo
      include Purdie::Ingester

      def get url
        @id = Purdie.get_id url
        target = "#{Vimeo.host}/videos/#{@id}"
        response = HTTParty.get target, headers: Vimeo.headers
        JSON.parse response.body
      end

      def distill url
        video = get url
        results = {}

        results['title'] = video['name']
        results['id'] = @id
        results['license'] = @config['license_lookups'][video['license']]['full_name']
        results['license_url'] = @config['license_lookups'][video['license']]['url']

        results
      end

      def self.headers
        {
          'Authorization' => "bearer #{ENV['VIMEO_BEARER_TOKEN']}",
          'Accept' => 'application/json'
        }
      end

      def self.resolve_set url
        target = "#{Vimeo.host}/albums/#{Purdie.get_id url}/videos/"
        set = JSON.parse (HTTParty.get target, headers: Vimeo.headers).body
        set['data'].map { |video| video['link'] }
      end

      def self.matcher
        'vimeo.com'
      end

      def self.host
        'https://api.vimeo.com'
      end
    end
  end
end
