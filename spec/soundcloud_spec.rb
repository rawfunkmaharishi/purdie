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
        track = @sc.get_track 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
        expect(track).to be_a Hash
        expect(track['id']). to eq 193008299
      end

      it 'renders YAML' do
        yaml = @sc.yamlise 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
        expect(yaml).to eq "---\ntitle: Hexaflexagon\nid: 193008299\nlocation: Islington Academy\ndate: '2015-02-18'\nlicense: Attribution-NonCommercial-ShareAlike\nlicense_url: http://creativecommons.org/licenses/by-nc-sa/4.0/\n"
      end
    end
  end
end
