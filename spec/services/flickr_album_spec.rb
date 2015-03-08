require 'spec_helper'

module Purdie
  module Services
    describe Flickr do
      before :each do
        @f = Flickr.new Config.new
      end

      it 'distills data for a set', :vcr do
        dist = @f.distill 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
        expect(@f.count).to eq 6
        expect(@f[5].to_yaml).to eq (
"---
title: Embothrium seedling
date: '2015-02-16'
photo_page: https://www.flickr.com/photos/pikesley/16367228619/
photo_url: https://farm9.staticflickr.com/8660/16367228619_3af2aba147_m.jpg
license: Attribution-NonCommercial-ShareAlike
license_url: https://creativecommons.org/licenses/by-nc-sa/2.0/
photographer: pikesley
"
        )
      end
    end

    describe Bernard do
      it 'dumps data for a set', :vcr do
        @b = Bernard.new
        @b.config['output_dir'] = 'tmp/'
        @b.grab 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
        @b.dump

        expect(File).to exist 'tmp/flickr.yaml'
        FileUtils.rm 'tmp/flickr.yaml'
      end

      it 'dumps data from a source file', :vcr do
        FileUtils.mkdir_p 'tmp/albums'
        File.open 'tmp/albums/pictures', 'w' do |f|
          f.write 'https://www.flickr.com/photos/pikesley/sets/72157649827363868/'
          f.write "\n"
        end
        @b = Bernard.new
        @b.config['output_dir'] = 'tmp/albums'
        @b.source_file = 'tmp/albums/pictures'

        @b.fetch

        expect(File).to exist 'tmp/albums/flickr.yaml'
      end
    end
  end
end
