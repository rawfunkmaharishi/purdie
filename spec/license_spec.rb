require 'spec_helper'

module Purdie
  describe License do
    it 'returns a default license' do
      @l = License.new
      expect(@l['type']).to eq 'Creative Commons'
      expect(@l['short_name']).to eq 'BY-NC-SA'
      expect(@l['full_name']).to eq 'Attribution-NonCommercial-ShareAlike'
      expect(@l['url']).to eq 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
    end
  end
end
