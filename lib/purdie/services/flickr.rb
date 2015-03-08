require 'purdie'

Dotenv.load

FlickRaw.api_key = ENV['FLICKR_API_KEY']
FlickRaw.shared_secret = ENV['FLICKR_SECRET']

module Purdie
  module Services
    class Flickr
      include Purdie::Ingester

      def configure
        @matcher = 'flickr.com'
        @output_file = 'flickr.yaml'

        super
      end

      def licenses
        @licenses ||= flickr.photos.licenses.getInfo
      end

      def get url
        flickr.photos.getInfo photo_id: Purdie.get_id(url)
      end

      def distill url
        if url =~ /\/sets\//
          f = flickr.photosets.getPhotos(photoset_id: Purdie.get_id(url))['photo']
          f.map { |p| p.id.to_i }.each do |id|
            u = flickr.photos.getInfo(photo_id: id)
            self.ingest u['urls'][0]['_content']
          end
        else

          photo = get url
          results = {}

          results['title'] = photo['title']
          results['title'] = @config['default_title'] if photo['title'] == ''
          results['date'] = photo['dates']['taken'].split(' ')[0]
          results['photo_page'] = photo['urls'][0]['_content']
          results['photo_url'] = FlickRaw.url_m(photo)

          license = licenses.select {|l| l['id'] == photo['license']}[0]
          results['license'] = license['name'].split(' License')[0]
          results['license_url'] = license['url']

          begin
            snapper = photo['tags'].select { |t| t['raw'] =~ /photographer/ }[0]
            results['photographer'] = snapper['raw'].split(':')[1]
          rescue NoMethodError
            if @config['photographer_lookups']
              results['photographer'] = @config['photographer_lookups'][photo['owner']['username']]
            else
              results['photographer'] = photo['owner']['username']
            end
            unless results['photographer']
              results['photographer'] = photo['owner']['username']
            end
          end
          results

        end
      end
    end
  end
end
