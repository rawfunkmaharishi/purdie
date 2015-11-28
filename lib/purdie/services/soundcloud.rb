require 'soundcloud'

module Purdie
  module Services
    class SoundCloud
      include Purdie::Service

      def client
        @client ||= ::SoundCloud.new client_id: ENV['SOUNDCLOUD_CLIENT_ID']
      end

      def distill url
        begin
          track = client.get '/resolve', url: url
        rescue ArgumentError => ae
          raise CredentialsException.new self, 'missing'
        rescue ::SoundCloud::ResponseError => re
          raise CredentialsException.new self, 'duff'
        end

        results = {}
        results['title'] = track['title']
        results['id'] = track['id']

        description = YAML.load track['description']
        if description.class == Hash
          description.keys.each do |k|
            results[k] = description[k]
          end
        else
          results['location'] = track['description']
        end

        results['date'] = "%4d-%02d-%02d" % [ track['release_year'], track['release_month'], track['release_day'] ]

        results.attach_license self, track['license']

        results
      end

      def self.resolve url
        return [url] unless url =~ /\/sets\//

        client = ::SoundCloud.new client_id: ENV['SOUNDCLOUD_CLIENT_ID']
        client.get('/resolve', url: url).tracks.
          map { |track| track['permalink_url'] }
      end

      def self.matcher
        'soundcloud.com'
      end
    end
  end
end
