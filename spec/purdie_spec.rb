require 'spec_helper'

module Purdie
  describe Bernard do
    it 'has config' do
      b = Bernard.new File.join(File.dirname(__FILE__), '..', 'features/support/fixtures/config/purdie')
      expect(b.config['soundcloud']['client_id']).to eq 123456
      expect(b.config['output_dir']).to eq '_data'
    end

    it 'connects to soundcloud', :vcr do
      b = Bernard.new File.join(File.dirname(__FILE__), '..', '.purdie')
    end
  end
end
