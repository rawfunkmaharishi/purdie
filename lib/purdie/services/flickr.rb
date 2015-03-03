require 'purdie'
require 'flickraw-cached'

Dotenv.load

module Purdie
  module Services
    class Flickr
      include Purdie::Ingester

      attr_reader :items

      def initialize config
        @config = config
        @items = []

        FlickRaw.api_key = ENV['FLICKR_API_KEY']
        FlickRaw.shared_secret = ENV['FLICKR_SECRET']
      end

      def get_photo url
        flickr.photos.getInfo photo_id: Purdie.get_id(url)
      end

      def distill url
        photo = get_photo url
        results = {}

        results['title'] = photo['title']
        results['title'] = @config['default-title'] if photo['title'] == ''
        results['date'] = photo['dates']['taken'].split(' ')[0]
        results['photo_page'] = photo['urls'][0]['_content']
        results['photo_url'] = FlickRaw.url_m(photo)

        @licenses = flickr.photos.licenses.getInfo
        license = @licenses.select {|l| l['id'] == photo['license']}[0]
        results['license'] = license['name'].split(' License')[0]
        results['license_url'] = license['url']

        begin
          snapper = photo['tags'].select { |t| t['raw'] =~ /photographer/ }[0]
          results['photographer'] = snapper['raw'].split(':')[1]
        rescue NoMethodError
          results['photographer'] = @config['photographer-lookups'][photo['owner']['username']]
          unless results['photographer']
            results['photographer'] = photo['owner']['username']
          end
        end

        results
      end
    end
  end
end
