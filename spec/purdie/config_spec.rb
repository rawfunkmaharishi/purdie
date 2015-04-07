require 'spec_helper'

module Purdie
  describe Config do
    let(:conf) { Purdie::Config.instance.config }

    it 'has defaults' do
      expect(conf['output_dir']).to eq '_data'
    end

    it 'reads a local config file' do
      expect(conf.default_title).to eq 'Raw Funk Maharishi'
    end
  end
end
