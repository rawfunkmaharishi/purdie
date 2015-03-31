require 'spec_helper'

module Purdie
  describe Resolver do
    it 'returns a single-item list for a regular item url', :vcr do
      resolved = Resolver.resolve 'https://www.flickr.com/photos/pikesley/16252009191/'
      expect(resolved.count).to eq 1
      expect(resolved.first).to eq 'https://www.flickr.com/photos/pikesley/16252009191/'
    end

    it 'resolves a Flickr set', :vcr do
      resolved = Resolver.resolve 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
      expect(resolved.count).to eq 12
      expect(resolved[0]).to eq 'https://www.flickr.com/photos/pikesley/16252009191/'
      expect(resolved[7]).to eq 'https://www.flickr.com/photos/pikesley/16752239531/'
    end

    it 'resolves a SoundCloud set', :vcr do
      resolved = Resolver.resolve 'https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions'
      expect(resolved.count).to eq 4
    end

    it 'uniques a list when an item appears multiple times' do
      sources = [
        'http://soundcloud.com/rawfunkmaharishi/beer-of-course-but-why',
        'https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions'
      ]
      resolved = Resolver.resolve sources
      expect(resolved.count).to eq 4
      expect(Purdie.strip_scheme resolved[0]).to eq '//soundcloud.com/rawfunkmaharishi/beer-of-course-but-why'
      expect(Purdie.strip_scheme resolved[2]).to eq '//soundcloud.com/rawfunkmaharishi/junalbandi-3'
    end

    it 'resolves a YouTube playlist', :vcr do
      resolved = Resolver.resolve 'https://www.youtube.com/playlist?list=PLuPLM2FI60-OIgFTc9YCrGgH5XWGT6znV'
      expect(resolved.count).to eq 9
      expect(Purdie.strip_scheme resolved.first).to eq '//youtube.com/watch?v=U23Ezi6q30E'
    end
  end
end
