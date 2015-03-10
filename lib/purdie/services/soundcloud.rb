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
        results['license'] = @config['license_lookups'][track['license']]['full_name']
        results['license_url'] = @config['license_lookups'][track['license']]['url']

        results
      end

      def self.matcher
        'soundcloud.com'
      end

      def self.resolve_set url
        client = ::SoundCloud.new client_id: ENV['SOUNDCLOUD_CLIENT_ID']
        client.get('/resolve', url: url).tracks.
          map { |track| track['permalink_url'] }
      end
    end
  end
end
