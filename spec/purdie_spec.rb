require 'spec_helper'

module Purdie
  describe Bernard do
    it 'has config' do
      b = Bernard.new
      expect(b.config['output_dir']).to eq '_data'
    end

    it 'does not throw a fit when initialized with no _sources dir' do
      FileUtils.rmdir File.join(File.dirname(__FILE__), '..', '_sources')
      b = Bernard.new
      expect {b.fetch}.to raise_error
    end
  end
end
