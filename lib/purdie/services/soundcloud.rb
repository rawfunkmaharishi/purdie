require 'purdie'

Dotenv.load

module Purdie
  module Services
    class SoundCloud
      include Purdie::Ingester

      def configure
        @host = 'https://api.soundcloud.com'
        @matcher = 'soundcloud.com'

        super
      end

      def all_tracks
        @all_tracks ||= begin
          url = "#{@host}/users/#{ENV['SOUNDCLOUD_USER_ID']}/tracks?client_id=#{ENV['SOUNDCLOUD_CLIENT_ID']}"
          response = HTTParty.get url
          JSON.parse response.body
        end
      end

      def get url
        all_tracks.select do |track|
          Purdie.strip_scheme(track['permalink_url']) == Purdie.strip_scheme(url)
        end[0]
      end

      def distill url
        track = get url
        results = {}
        results['title'] = track['title']
        results['id'] = track['id']
        results['location'] = track['description']
        results['date'] = "%4d-%02d-%02d" % [ track['release_year'], track['release_month'], track['release_day'] ]
        results['license'] = @config['license_lookups'][track['license']]['full_name']
        results['license_url'] = @config['license_lookups'][track['license']]['url']

        results
      end
    end
  end
end
