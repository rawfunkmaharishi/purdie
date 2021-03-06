require 'flickraw-cached'

FlickRaw.api_key = ENV['FLICKR_API_KEY']
FlickRaw.shared_secret = ENV['FLICKR_SECRET']

module Purdie
  module Services
    class Flickr
      attr_accessor :size

      include Purdie::Service

      def configure
        @size = 240 # pixels
        super
      end

      def licenses
        @licenses ||= flickr.photos.licenses.getInfo
      end

      def get url
        begin
          flickr.photos.getInfo photo_id: Purdie.get_id(url)
        rescue FlickRaw::FlickrAppNotConfigured => fanc
          raise Purdie::CredentialsException.new self, 'missing' if fanc.message == 'No API key or secret defined!'
        rescue FlickRaw::FailedResponse => fr
          raise Purdie::CredentialsException.new self, 'duff' if fr.message == "'flickr.photos.getInfo' - Invalid API Key (Key has invalid format)"
        end
      end

      def distill url
        photo = get url
        results = {}

        results['title'] = photo['title']
        results['title'] = @config['default_title'] if photo['title'] == ''
        results['date'] = photo['dates']['taken'].split(' ')[0]
        results['photo_page'] = url
        results['photo_url'] = FlickRaw.send(Flickr.url_for_size(@size), photo)

        license = licenses.select {|l| l['id'] == photo['license']}[0]
        results['license'] = license['name'].split(' License')[0]
        results['license_url'] = license['url']

# WTF?
#        results.attach_license self, photo['license']

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

      def self.url_for_size size = nil
        size = 500 unless size

        case
          when size <= 75
            return :url_s
          when size <= 100
            return :url_t
          when size <= 150
            return :url_q
          when size <= 240
            return :url_m
          when size <= 320
            return :url_n
          when size <= 500
            return :url
          when size <= 640
            return :url_z
          when size <= 800
            return :url_c
          when size <= 1024
            return :url_b
          else
            return :url_o
        end
      end

      def self.resolve url
        return [url] unless url =~ /\/sets\//

        flickr.photosets.getPhotos(photoset_id: Purdie.get_id(url))['photo'].
          map { |member| member['id'] }.
          map { |id| flickr.photos.getInfo photo_id: id }.
          map { |picture| picture['urls'][0]['_content'] }
      end


      def self.matcher
        'flickr.com'
      end
    end
  end
end
