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

    it 'strips a scheme' do
      expect(Purdie.strip_scheme 'http://foo.bar/stuff').to eq 'foo.bar/stuff'
      expect(Purdie.strip_scheme 'https://bar.foo/stuff').to eq 'bar.foo/stuff'
    end
  end
end
