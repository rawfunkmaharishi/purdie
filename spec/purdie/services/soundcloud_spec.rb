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
url: http://soundcloud.com/rawfunkmaharishi/hexaflexagon-1
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
url: http://soundcloud.com/rawfunkmaharishi/don-the-crown-1
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

      context 'handle missing fields' do
        it 'behaves gracefully when there is no date', :vcr do
          expect { @sc.distill 'https://soundcloud.com/rawfunkmaharishi/nrf' }.to raise_exception { |exception|
            expect(exception).to be_a Purdie::MetadataException
            expect(exception.service.class).to eq Purdie::Services::SoundCloud
            expect(exception.message).to eq ("'https://soundcloud.com/rawfunkmaharishi/nrf' does not have a release date")
          }
        end

        it 'is fine when there is no location', :vcr do
          expect { @sc.distill 'https://soundcloud.com/rawfunkmaharishi/nrf' }.to raise_exception { |exception|
            expect(exception).to be_a Purdie::MetadataException
            expect(exception.service.class).to eq Purdie::Services::SoundCloud
            expect(exception.message).to eq ("'https://soundcloud.com/rawfunkmaharishi/nrf' does not have a location")
          }
        end
      end
    end
  end
end
