require 'spec_helper'

module Purdie
  describe Bernard do
    it 'processes files', :vcr do
      FileUtils.cp 'spec/support/fixtures/soundcloud.sounds', '_sources/'
      FileUtils.cp 'spec/support/fixtures/vimeo.vids', '_sources/'
      b = Bernard.new
      b.fetch
    end
  end
end
