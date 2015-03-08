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

      it 'gets an id' do
        expect(YouTube.get_id 'https://www.youtube.com/watch?v=JCix1XW329g').to eq 'JCix1XW329g'
        expect(YouTube.get_id 'https://www.youtube.com/watch?v=Qt_J0jNqtZg&list=PLuPLM2FI60-M0-aWejF9WgB-Dkt1TuQXv&index=2').to eq 'Qt_J0jNqtZg'
      end
    end
  end
end
