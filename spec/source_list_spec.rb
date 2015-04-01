require 'spec_helper'

module Purdie
  describe SourceList do
    it 'takes a single item' do
      sl = SourceList.new 'https://soundcloud.com/rawfunkmaharishi/junalbandi-3'
      expect(sl.count).to eq 1
      expect(sl[0]).to be_a Purdie::Item
      expect(sl[0].url).to eq 'https://soundcloud.com/rawfunkmaharishi/junalbandi-3'
    end

    it 'takes an array' do
      sources = [
        'https://soundcloud.com/rawfunkmaharishi/bernard',
        'https://soundcloud.com/rawfunkmaharishi/junalbandi-3',
        'https://soundcloud.com/rawfunkmaharishi/beer-of-course-but-why'
      ]
      sl = SourceList.new sources
      expect(sl.count).to eq 3
      expect(sl.first).to be_a Purdie::Item
      expect(sl[0].url).to eq 'https://soundcloud.com/rawfunkmaharishi/bernard'
    end

    it 'constructs a list from a set URL', :vcr do
      sl = SourceList.new 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
      expect(sl.count).to eq 12
      expect(sl[0].url).to eq 'https://www.flickr.com/photos/pikesley/16252009191/'
      expect(sl[7].url).to eq 'https://www.flickr.com/photos/pikesley/16752239531/'
    end

    it 'can be initialiased from a file' do
      sl = SourceList.from_file 'spec/support/fixtures/soundcloud.sounds'
      expect(sl.first).to be_a Purdie::Item
      expect(sl[3].url).to eq 'https://soundcloud.com/rawfunkmaharishi/funk-taxi-berlin'
    end

    it 'can be initialiased from a Vimeo file' do
      sl = SourceList.from_file 'spec/support/fixtures/vimeo.vids'
      expect(sl[2].url).to eq 'https://vimeo.com/110132671'
    end

    it 'deals with comments in a source file' do
      sl = SourceList.from_file 'spec/support/fixtures/with-comments.source'
      expect(sl.count).to eq 2
    end

    it 'does something sensible with an unrecognised URL' do
      sl = SourceList.new 'http://foo.com/bar'
      expect(sl.count).to eq 0
    end

    it 'knows what file it came from' do
      sl = SourceList.from_file 'spec/support/fixtures/vimeo.vids'
      expect(sl.parent_file).to eq 'spec/support/fixtures/vimeo.vids'
    end

    context 'process its items' do
      it 'processes items', :vcr do
        sl = SourceList.from_file 'spec/support/fixtures/vimeo.vids'
        sl.process

        expect(sl.items[0]).to be_a Purdie::Item
        expect(sl.items[0]['title']).to eq 'Safety On Board'
      end
    end

    context 'make output' do
      it 'has the correct output path' do
        FileUtils.cp 'spec/support/fixtures/soundcloud.sounds', '_sources/'
        sl = SourceList.from_file '_sources/soundcloud.sounds'
        expect(sl.parent_file).to eq '_sources/soundcloud.sounds'
        expect(sl.output_file).to eq '_data/soundcloud.yaml'
      end

      it 'has the correct output path when the source path has no extension' do
        FileUtils.cp 'spec/support/fixtures/soundcloud.sounds', '_sources/sounds'
        sl = SourceList.from_file '_sources/sounds'
        expect(sl.output_file).to eq '_data/sounds.yaml'
      end

      it 'actually makes output', :vcr do
        FileUtils.cp 'spec/support/fixtures/output-generator', '_sources/'
        sl = SourceList.from_file '_sources/output-generator'
        sl.write

        expect(File).to exist '_data/output-generator.yaml'

        lines = File.readlines '_data/output-generator.yaml'
        expect(lines).to include "- title: Not Bernard\n",
                                 "  id: 190803089\n",
                                 "  location: Rogue Studios\n",
                                 "  date: '2015-02-11'\n",
                                 "  license: Attribution-NonCommercial-ShareAlike\n",
                                 "  license_url: http://creativecommons.org/licenses/by-nc-sa/4.0/\n"

      end
    end
  end
end
