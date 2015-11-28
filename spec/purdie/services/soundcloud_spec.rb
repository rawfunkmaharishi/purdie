require 'spec_helper'

module Purdie
  module Services
    describe SoundCloud do
      before :each do
        @sc = SoundCloud.new
      end

      it 'has a SoundCloud client' do
        expect(@sc.client.class.name).to eq 'SoundCloud::Client'
      end

      it 'distills the data', :vcr do
        distilled = @sc.distill 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
        expect(distilled.to_yaml).to eq(
"---
title: Hexaflexagon
id: 193008299
location: Islington Academy
date: '2015-02-18'
license: Attribution-NonCommercial-ShareAlike
license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
"
        )
      end

      it 'distills richer metadata', :vcr do
        distilled = @sc.distill 'https://soundcloud.com/rawfunkmaharishi/don-the-crown-1'
        expect(distilled.to_yaml).to eq(
"---
title: Don The Crown
id: 234830006
location: Rogue Studios
engineer: Alessio
date: '2015-11-25'
license: Attribution-NonCommercial-ShareAlike
license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/
"
        )
      end

      context 'resolve a set' do
        it 'resolves a set from a url', :vcr do
          set = SoundCloud.resolve 'https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions'
          expect(set[0]).to eq 'http://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
          expect(set[3]).to eq 'http://soundcloud.com/rawfunkmaharishi/bernard'
        end
      end
    end
  end
end
