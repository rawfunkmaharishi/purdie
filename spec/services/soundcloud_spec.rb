require 'spec_helper'

module Purdie
  module Services
    describe SoundCloud do
      before :each do
        @sc = SoundCloud.new Config.new
      end

      it 'connects to SoundCloud', :vcr do
        expect(@sc.all_tracks).to be_a Array
      end

      it 'extracts a track' do
        track = @sc.get_track 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
        expect(track).to be_a Hash
        expect(track['id']). to eq 193008299
      end

      it 'refines the data' do
        refined = @sc.refine 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
        expect(refined).to eq({
          "title"=>"Hexaflexagon",
          "id"=>193008299,
          "location"=>"Islington Academy",
          "date"=>"2015-02-18",
          "license"=>"Attribution-NonCommercial-ShareAlike",
          "license_url"=>"http://creativecommons.org/licenses/by-nc-sa/4.0/"})
      end
    end
  end
end
