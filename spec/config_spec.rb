require 'spec_helper'

module Purdie
  describe Config do
    it 'has defaults' do
      c = Config.new
      expect(c['output_dir']).to eq '_data'
    end
  end
end
