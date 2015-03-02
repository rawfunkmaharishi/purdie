require 'purdie'
require 'flickraw-cached'

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

        flickr.photos.getInfo(photo_id: id)
      end

      def refine url
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
