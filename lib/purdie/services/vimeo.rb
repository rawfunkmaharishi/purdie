require 'purdie'

module Purdie
  module Services
    class Vimeo
      include Purdie::Ingester

      def configure
        @host = 'https://api.vimeo.com'
        @matcher = 'vimeo.com'
        @output_file = 'vimeo.yaml'
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
        results['license'] = @config['license-lookups'][video['license']]['full-name']
        results['license_url'] = @config['license-lookups'][video['license']]['url']

        results
      end
    end
  end
end
