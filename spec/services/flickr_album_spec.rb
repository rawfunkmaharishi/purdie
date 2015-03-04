require 'spec_helper'

module Purdie
  module Services
    describe Flickr do
      before :each do
        @f = Flickr.new Config.new
      end

      it 'distills data for a regular photo', :vcr do
        dist = @f.distill 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'

      end
    end
  end
end
