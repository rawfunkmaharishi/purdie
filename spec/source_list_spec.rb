require 'spec_helper'

module Purdie
  describe SourceList do
    it 'has source items' do
      sources = [
        'https://soundcloud.com/rawfunkmaharishi/bernard',
        'https://soundcloud.com/rawfunkmaharishi/junalbandi-3',
        'https://soundcloud.com/rawfunkmaharishi/beer-of-course-but-why'
      ]
      sl = SourceList.new sources

      expect(sl[0]).to eq 'https://soundcloud.com/rawfunkmaharishi/bernard'
    end

    it 'can be initialiased from a file' do
      sl = SourceList.from_file 'spec/support/fixtures/soundcloud.sounds'
      expect(sl[3]).to eq 'https://soundcloud.com/rawfunkmaharishi/funk-taxi-berlin'
    end
  end
end
