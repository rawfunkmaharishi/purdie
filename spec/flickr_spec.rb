require 'spec_helper'

module Purdie
  module Services
    describe Flickr do
      before :each do
        @f = Flickr.new Config.new $config_file
      end

      it 'gets data for a photo', :vcr do
        expect(@f.get_photo 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/
').to be_a FlickRaw::Response
      end
    end
  end
end
