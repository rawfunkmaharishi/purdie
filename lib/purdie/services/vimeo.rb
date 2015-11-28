module Purdie
  module Services
    class Vimeo
      include Purdie::Service

      def get url
        @id = Purdie.get_id url
        target = "#{Vimeo.host}/videos/#{@id}"
        response = HTTParty.get target, headers: Vimeo.headers
        response = JSON.parse response.body
        if response['error'] == 'You must provide a valid authenticated access token.'
          raise CredentialsException.new self, 'missing and/or duff'
        else
          response
        end
      end

      def distill url
        video = get url

        results = {}
        results['title'] = video['name']
        results['id'] = @id

        results.attach_license self, video['license']

        results
      end

      def self.headers
        {
          'Authorization' => "bearer #{ENV['VIMEO_BEARER_TOKEN']}",
          'Accept' => 'application/json'
        }
      end

      def self.resolve url
        return [url] unless url =~ /\/albums?\//

        target = "#{Vimeo.host}/albums/#{Purdie.get_id url}/videos/"
        set = JSON.parse (HTTParty.get target, headers: Vimeo.headers).body
        set['data'].map { |video| video['uri'].sub '/videos', 'https://vimeo.com' }
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
