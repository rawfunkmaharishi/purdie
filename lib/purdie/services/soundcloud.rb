require 'purdie'
require 'soundcloud'

module Purdie
  module Services
    class SoundCloud
      include Purdie::Ingester

      def client
        @client ||= ::SoundCloud.new client_id: ENV['SOUNDCLOUD_CLIENT_ID']
      end

      def distill url
        track = client.get '/resolve', url: url
        results = {}
        results['title'] = track['title']
        results['id'] = track['id']
        results['location'] = track['description']
        results['date'] = "%4d-%02d-%02d" % [ track['release_year'], track['release_month'], track['release_day'] ]

        results.attach_license LicenseManager.get self, track['license']

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
