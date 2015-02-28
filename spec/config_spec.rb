require 'spec_helper'

module Purdie
  describe Config do
    it 'has defaults' do
      c = Config.new
      expect(c['output-dir']).to eq '_data'
    end

    it 'has custom stuff alongside defaults' do
      c = Config.new File.join(File.dirname(__FILE__), '..', 'features/support/fixtures/config/purdie')
      expect(c['soundcloud']['host']).to eq 'https://api.soundcloud.com'
      expect(c['soundcloud']['client_id']).to eq 123456
    end
  end
end
