require 'spec_helper'

module Purdie
  module Services
    describe Flickr do
      before :each do
        @f = Flickr.new Config.new
      end

      it 'distills data for a regular photo', :vcr do
        expect(@f.distill 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/').to eq({
          "title"=>"The Comedy, October 2014",
          "date"=>"2014-10-22",
          "photo_page"=>"https://www.flickr.com/photos/rawfunkmaharishi/15631479625/",
          "photo_url"=>"https://farm4.staticflickr.com/3933/15631479625_b6168ee903_m.jpg",
          "license"=>"Attribution-NonCommercial-ShareAlike",
          "license_url"=>"https://creativecommons.org/licenses/by-nc-sa/2.0/",
          "photographer"=>"kim"
        })
      end

      it 'ingests data for a photo without a specific photographer tag', :vcr do
        @f.ingest 'https://www.flickr.com/photos/cluttercup/15950875724/'
        expect(@f[0]).to eq ({
          "title"=>"Raw Funk Maharishi",
          "date"=>"2015-02-18",
          "photo_page"=>"https://www.flickr.com/photos/cluttercup/15950875724/",
          "photo_url"=>"https://farm8.staticflickr.com/7398/15950875724_23d58be214_m.jpg",
          "license"=>"Attribution-NonCommercial",
          "license_url"=>"https://creativecommons.org/licenses/by-nc/2.0/",
          "photographer"=>"jane"
        })
      end

      it 'falls back to the default photographer name', :vcr do
        expect(@f.distill('https://www.flickr.com/photos/pikesley/16649739916/')['photographer']).to eq 'pikesley'
      end
    end
  end
end
