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

      it 'extracts a track', :vcr do
        track = @sc.get 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
        expect(track).to be_a Hash
        expect(track['id']). to eq 193008299
      end

      it 'distills the data', :vcr do
        distilld = @sc.distill 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
        expect(distilld).to eq({
          "title"=>"Hexaflexagon",
          "id"=>193008299,
          "location"=>"Islington Academy",
          "date"=>"2015-02-18",
          "license"=>"Attribution-NonCommercial-ShareAlike",
          "license_url"=>"http://creativecommons.org/licenses/by-nc-sa/4.0/"})
      end

      it 'ingests a track', :vcr do
        @sc.ingest 'https://soundcloud.com/rawfunkmaharishi/bernard'
        expect(@sc[0]).to eq({
          "title"=>"Bernard",
          "id"=>192841052,
          "location"=>"Islington Academy",
          "date"=>"2015-02-18",
          "license"=>"Attribution-NonCommercial-ShareAlike",
          "license_url"=>"http://creativecommons.org/licenses/by-nc-sa/4.0/"
          })
      end
    end
  end
end
