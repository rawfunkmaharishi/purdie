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

    it 'sanitises a URL' do
      expect(Purdie.sanitise_url 'http://foo.bar/stuff/').to eq 'http://foo.bar/stuff'
    end

    it 'gets an id' do
      expect(Purdie.get_id 'http://foo.bar/654321').to eq 654321
    end
  end
end
