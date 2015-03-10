require 'spec_helper'

module Purdie
  describe SourceList do
    it 'takes a single item' do
      sl = SourceList.new 'https://soundcloud.com/rawfunkmaharishi/junalbandi-3'
      expect(sl.count).to eq 1
      expect(sl[0]).to eq 'https://soundcloud.com/rawfunkmaharishi/junalbandi-3'
    end

    it 'takes an array' do
      sources = [
        'https://soundcloud.com/rawfunkmaharishi/bernard',
        'https://soundcloud.com/rawfunkmaharishi/junalbandi-3',
        'https://soundcloud.com/rawfunkmaharishi/beer-of-course-but-why'
      ]
      sl = SourceList.new sources
      expect(sl.count).to eq 3
      expect(sl[0]).to eq 'https://soundcloud.com/rawfunkmaharishi/bernard'
    end

    context 'resolve sets' do
      it 'resolves a Flickr set', :vcr do
        resolved = SourceList.resolve_set 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
        expect(resolved.count).to eq 8
        expect(resolved[0]).to eq 'https://www.flickr.com/photos/pikesley/16252009191/'
        expect(resolved[7]).to eq 'https://www.flickr.com/photos/pikesley/16752239531/'
      end

      it 'resolves a SoundCloud set', :vcr do
        resolved = SourceList.resolve_set 'https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions'
        expect(resolved.count).to eq 4
      end

      it 'constructs a list from a set URL', :vcr do
        sl = SourceList.new 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
        expect(sl.count).to eq 8
        expect(sl[0]).to eq 'https://www.flickr.com/photos/pikesley/16252009191/'
        expect(sl[7]).to eq 'https://www.flickr.com/photos/pikesley/16752239531/'
      end
    end

    it 'can be initialiased from a file' do
      sl = SourceList.from_file 'spec/support/fixtures/soundcloud.sounds'
      expect(sl[3]).to eq 'https://soundcloud.com/rawfunkmaharishi/funk-taxi-berlin'
    end
  end
end
