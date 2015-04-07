require 'spec_helper'

module Purdie
  describe LicenseManager do
    it 'returns a license' do
      l = LicenseManager.get Purdie::Services::SoundCloud, 'cc-by-nc-sa'
      expect(l['short_name']).to eq 'BY-NC-SA'
      expect(l['full_name']).to eq 'Attribution-NonCommercial-ShareAlike'
      expect(l.url).to eq 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
    end

    it 'barfs on an unknown license' do
      expect { l = LicenseManager.get Purdie::Services::Vimeo, 'fake-license' }.to raise_exception { |e|
        expect(e).to be_a LicenseException
        expect(e.service).to eq Purdie::Services::Vimeo
        expect(e.name).to eq 'fake-license'
      }
    end
  end
end
