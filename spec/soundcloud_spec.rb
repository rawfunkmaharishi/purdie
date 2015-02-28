require 'spec_helper'

module Purdie
  module Services
    describe SoundCloud do
      it 'connects to SoundCloud', :vcr do
        s = SoundCloud.new Config.new $config_file
        expect(s.all_tracks).to be_a Array
      end
    end
  end
end
