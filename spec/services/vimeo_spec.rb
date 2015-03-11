require 'spec_helper'

module Purdie
  module Services
    describe Vimeo do
      before :each do
        @v = Vimeo.new Config.new
      end

      it 'gets a video', :vcr do
        expect(@v.get 'https://vimeo.com/117102891').to be_a Hash
      end

      it 'ingests a video', :vcr do
        @v.ingest 'https://vimeo.com/117102891'
        expect(@v[0].to_yaml).to eq(
"---
title: Bernard
id: 117102891
license: Attribution-NonCommercial-ShareAlike
license_url: http://creativecommons.org/licenses/by-nc-sa/3.0/
"
        )
      end

      context 'resolve an album' do
        it 'resolves an album from a URL' do
          # We're going to call this a set for consistency
          set = Vimeo.resolve 'https://vimeo.com/album/3296736'
          expect(set.count).to eq 3
          expect(set).to eq [
            'https://vimeo.com/111356018',
            'https://vimeo.com/110133117',
            'https://vimeo.com/110132671'
          ]
        end
      end
    end
  end
end
