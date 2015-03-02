require 'spec_helper'

module Purdie
  describe Config do
    it 'has defaults' do
      c = Config.new
      expect(c['output-dir']).to eq '_data'
    end

    it 'reads a local config file' do
      c = Config.new
      expect(c['default-title']).to eq 'Raw Funk Maharishi'
    end
  end
end
