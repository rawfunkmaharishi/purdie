require 'spec_helper'

module Purdie
  describe License do
    it 'returns a default license' do
      l = License.new
      expect(l[:type]).to eq 'Creative Commons'
      expect(l[:short_name]).to eq 'BY-NC-SA'
      expect(l[:full_name]).to eq 'Attribution-NonCommercial-ShareAlike'
      expect(l[:url]).to eq 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
    end

    it 'generates a license from a short name' do
      l = License.new 'BY-NC'
      expect(l[:full_name]).to eq 'Attribution-NonCommercial'
    end

    it 'generates a license from a different short name' do
      l = License.new 'BY'
      expect(l[:full_name]).to eq 'Attribution'
    end
  end
end
