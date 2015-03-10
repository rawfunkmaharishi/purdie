require 'purdie'

module Purdie
  module Services
    class Vimeo
      include Purdie::Ingester

      def configure
        @host = 'https://api.vimeo.com'
        super
      end

      def get url
        @id = Purdie.get_id url

        target = "#{@host}/videos/#{@id}"
        headers = {
          'Authorization' => "bearer #{ENV['VIMEO_BEARER_TOKEN']}",
          'Accept' => 'application/json'
        }
        response = HTTParty.get target, headers: headers

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
        
      def self.matcher
        'vimeo.com'
      end
    end
  end
end
