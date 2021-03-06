require 'spec_helper'

module Purdie
  describe Bernard do
    it 'does not throw a fit when initialized with no _sources dir' do
      FileUtils.rmdir File.join(File.dirname(__FILE__), '..', '..', '_sources')
      b = Bernard.new
      expect {b.fetch}.to raise_exception { |e|
        expect(e).to be_a Purdie::PurdieException
        expect(e.message).to eq 'No data sources specified'
      }
    end

    it 'processes files', :vcr do
      FileUtils.cp 'spec/support/fixtures/soundcloud.sounds', '_sources/'
      FileUtils.cp 'spec/support/fixtures/vimeo.vids', '_sources/'
      b = Bernard.new
      b.fetch

      expect(File).to exist '_data/soundcloud.yaml'

      lines = File.readlines '_data/soundcloud.yaml'
      expect(lines).to include "- title: Safety On Board\n",
                               "  id: 174628735\n",
                               "  location: Enterprise Studios\n",
                               "  date: '2014-10-14'\n",
                               "  license: Attribution-NonCommercial-ShareAlike\n",
                               "  license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/\n"
    end

    it 'deals with YouTube', :vcr do
      FileUtils.cp 'spec/support/fixtures/youtube.tubes', '_sources/'
      b = Bernard.new
      b.fetch

      expect(File).to exist '_data/youtube.yaml'
    end
  end
end
