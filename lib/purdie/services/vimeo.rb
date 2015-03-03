require 'purdie'

Dotenv.load

module Purdie
  module Services
    class Vimeo
      def initialize config
        @config = config
      end

      def get_video url
        url.strip!
        url = url[0..-2] if url[-1] == '/'
        @id = url.split('/')[-1].to_i

        target = "#{@config['services']['Vimeo']['host']}/videos/#{@id}"
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
