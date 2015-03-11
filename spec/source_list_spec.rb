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
        resolved = SourceList.resolve 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
        expect(resolved.count).to eq 8
        expect(resolved[0]).to eq 'https://www.flickr.com/photos/pikesley/16252009191/'
        expect(resolved[7]).to eq 'https://www.flickr.com/photos/pikesley/16752239531/'
      end

      it 'resolves a SoundCloud set', :vcr do
        resolved = SourceList.resolve 'https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions'
        expect(resolved.count).to eq 4
      end

      it 'constructs a list from a set URL', :vcr do
        sl = SourceList.new 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
        expect(sl.count).to eq 8
        expect(sl[0]).to eq 'https://www.flickr.com/photos/pikesley/16252009191/'
        expect(sl[7]).to eq 'https://www.flickr.com/photos/pikesley/16752239531/'
      end

      it 'uniques a list when an item appears multiple times' do
        sources = [
          'https://soundcloud.com/rawfunkmaharishi/beer-of-course-but-why',
          'https://soundcloud.com/rawfunkmaharishi/sets/islington-academy-sessions'
        ]
        sl = SourceList.new sources
        expect(sl.count).to eq 4
        expect(Purdie.strip_scheme sl[0]).to eq 'soundcloud.com/rawfunkmaharishi/beer-of-course-but-why'
        expect(Purdie.strip_scheme sl[2]).to eq 'soundcloud.com/rawfunkmaharishi/junalbandi-3'
      end
    end

    it 'can be initialiased from a file' do
      sl = SourceList.from_file 'spec/support/fixtures/soundcloud.sounds'
      expect(sl[3]).to eq 'https://soundcloud.com/rawfunkmaharishi/funk-taxi-berlin'
    end

    it 'can be initialiased from a Vimeo file' do
      sl = SourceList.from_file 'spec/support/fixtures/vimeo.vids'
      expect(sl[2]).to eq 'https://vimeo.com/110132671'
    end

    it 'deals with comments in a source file' do
      sl = SourceList.from_file 'spec/support/fixtures/with-comments.source'
      expect(sl.count).to eq 2
    end

    it 'does something sensible with an unrecognised URL' do
      sl = SourceList.new 'http://foo.com/bar'
      expect(sl.count).to eq 0
    end
  end
end
