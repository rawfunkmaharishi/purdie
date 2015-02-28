require 'purdie'

Dotenv.load '.purdie'

module Purdie
  module Services
    class SoundCloud
      def initialize config
        @config = config['soundcloud']
      end

      def all_tracks
        @all_tracks ||= begin
          url = "#{@config['host']}/users/#{ENV['SOUNDCLOUD_USER_ID']}/tracks?client_id=#{ENV['SOUNDCLOUD_CLIENT_ID']}"
          response = HTTParty.get url
          JSON.parse response.body
        end
      end

      def get_track url
        all_tracks.select do |track|
          Purdie.strip_scheme(track['permalink_url']) == Purdie.strip_scheme(url)
        end[0]
      end
    end
  end
end
