require 'spec_helper'

module Purdie
  describe Bernard do
    it 'has config' do
      b = Bernard.new
      expect(b.config['output-dir']).to eq '_data'
    end

    it 'strips a scheme' do
      expect(Purdie.strip_scheme 'http://foo.bar/stuff').to eq 'foo.bar/stuff'
      expect(Purdie.strip_scheme 'https://bar.foo/stuff').to eq 'bar.foo/stuff'
    end
  end
end
