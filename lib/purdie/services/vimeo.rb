require 'purdie'

Dotenv.load

module Purdie
  module Services
    class Vimeo
      include Purdie::Ingester
      
      attr_reader :items

      def initialize config
        @config = config
        @items = []
      end

      def get_video url
        @id = Purdie.get_id url

        target = "#{@config['services'][self.class.name.split('::')[-1]]['host']}/videos/#{@id}"
        headers = {
          'Authorization' => "bearer #{ENV['VIMEO_BEARER_TOKEN']}",
          'Accept' => 'application/json'
        }
        response = HTTParty.get target, headers: headers

        JSON.parse response.body
      end

      def distill url
        video = get_video url
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
