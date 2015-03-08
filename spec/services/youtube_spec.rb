require 'spec_helper'

module Purdie
  module Services
    describe YouTube do
      before :each do
        @yt = YouTube.new Config.new
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

      it 'gets an id' do
        expect(YouTube.get_id 'https://www.youtube.com/watch?v=JCix1XW329g').to eq 'JCix1XW329g'
        expect(YouTube.get_id 'https://www.youtube.com/watch?v=Qt_J0jNqtZg&list=PLuPLM2FI60-M0-aWejF9WgB-Dkt1TuQXv&index=2').to eq 'Qt_J0jNqtZg'
      end
    end
  end
end
