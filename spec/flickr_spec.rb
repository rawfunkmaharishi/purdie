require 'spec_helper'

module Purdie
  module Services
    describe Flickr do
      before :each do
        @f = Flickr.new Config.new $config_file
        Timecop.freeze '2015-03-01'
      end

      after :each do
        Timecop.return
      end

#      it 'gets data for a photo', :vcr do
#        expect(@f.get_photo 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/').to be_a FlickRaw::Response
#      end

      it 'refines data for a photo', :vcr do
        expect(@f.refine 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
').to eq({
          "title"=>"The Comedy, October 2014",
          "date"=>"2014-10-22",
          "photo_page"=>"https://www.flickr.com/photos/rawfunkmaharishi/15631479625/",
          "photo_url"=>"https://farm4.staticflickr.com/3933/15631479625_b6168ee903_m.jpg",
          "license"=>"Attribution-NonCommercial-ShareAlike",
          "license_url"=>"https://creativecommons.org/licenses/by-nc-sa/2.0/",
          "photographer"=>"kim"
        })
      end
    end
  end
end
