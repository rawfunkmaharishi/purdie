require 'spec_helper'

module Purdie
  module Services
    describe YouTube do
      before :each do
        @yt = YouTube.new
      end

      it 'gets a video', :vcr do
        expect(@yt.get 'https://www.youtube.com/watch?v=JCix1XW329g').to be_a Hash
      end

      it 'ingests a video', :vcr do
        @yt.ingest 'https://www.youtube.com/watch?v=JCix1XW329g'
        expect(@yt[0].to_yaml).to eq(
"---
title: EMFCamp 2014 Day 3 Lightning talk 6
id: JCix1XW329g
license: Attribution
license_url: https://creativecommons.org/licenses/by/3.0/
"
        )
      end

      it 'gets the correct license', :vcr do
        vid = @yt.distill 'https://www.youtube.com/watch?v=baQe6MoSAHw'
        expect(vid['license']).to eq 'YouTube'
      end

      context 'resolve a playlist', :vcr do
        it 'resolves a playlist from a shitty YouTube URL', :vcr do
          list = YouTube.resolve 'https://www.youtube.com/playlist?list=PLuPLM2FI60-OIgFTc9YCrGgH5XWGT6znV'
          expect(list.count).to eq 9
          expect(list[8]).to eq 'https://youtube.com/watch?v=P842kq0bnOc'
        end
      end
    end
  end
end
