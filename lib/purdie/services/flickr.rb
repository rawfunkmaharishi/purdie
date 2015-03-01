require 'purdie'
require 'flickraw'

Dotenv.load

module Purdie
  module Services
    class Flickr
      def initialize config
        @config = config
        FlickRaw.api_key = ENV['FLICKR_API_KEY']
        FlickRaw.shared_secret = ENV['FLICKR_SECRET']
      end

      def get_photo url

        url.strip!
        url = url[0..-2] if url[-1] == '/'
        id = url.split('/')[-1].to_i

        data = flickr.photos.getInfo(photo_id: id)
      end
    end
  end
end
