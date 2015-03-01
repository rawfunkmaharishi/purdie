require 'spec_helper'

module Purdie
  describe Config do
    it 'has defaults' do
      c = Config.new
      expect(c['output-dir']).to eq '_data'
    end

    it 'reads a local config file' do
      FileUtils.cp File.join(File.dirname(__FILE__), '..', 'features/support/fixtures/config/purdie.yaml'),
        File.join(File.dirname(__FILE__), '..', 'config/purdie.yaml')

      c = Config.new
      expect(c['default-title']).to eq 'Raw Funk Maharishi'

      FileUtils.rm File.join(File.dirname(__FILE__), '..', 'config/purdie.yaml')
    end
  end
end
