require 'spec_helper'

module Purdie
  module Services
    describe SoundCloud do
      it 'connects to SoundCloud', :vcr do
        s = SoundCloud.new
      end
    end
  end
end
