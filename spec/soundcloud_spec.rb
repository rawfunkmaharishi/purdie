require 'spec_helper'

module Purdie
  module Services
    describe SoundCloud do
      before :each do
        @sc = SoundCloud.new Config.new $config_file
      end

      it 'connects to SoundCloud', :vcr do
        expect(@sc.all_tracks).to be_a Array
      end

      it 'extracts a track' do
        expect(@sc.get_track 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1').to be_a Hash
      end
    end
  end
end
