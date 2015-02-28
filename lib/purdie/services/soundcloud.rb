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
          url = "#{@config['host']}/tracks?client_id=#{ENV['SOUNDCLOUD_CLIENT_ID']}"
          response = HTTParty.get url
          JSON.parse response.body
        end
      end
    end
  end
end
