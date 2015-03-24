require 'spec_helper'

module Purdie
  describe Item do
    before :each do
      @i = Item.new 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
    end

    it 'has a URL' do
      expect(@i.url).to eq 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
    end

    it 'stores datas' do
      @i['license'] = 'cc-by-sa'
      expect(@i['license']).to eq 'cc-by-sa'
    end

    it 'presents YAML' do
      @i['drums'] = 'Purdie'
      @i['bass'] = 'Rainey'

      expect(@i.to_yaml).to eq (
"---
drums: Purdie
bass: Rainey
"
      )
    end

    it 'knows what file it came from' do
      sl = instance_double('SourceList', parent_file: 'some/path/bernard.purdie')
      @i.source_list = sl
      expect(@i.parent_file).to eq 'some/path/bernard.purdie'
    end

    it 'knows what service it belongs to' do
      expect(@i.service.class).to eq Purdie::Services::SoundCloud
    end

    it 'populates itself', :vcr do
      @i.distill
      expect(@i['title']).to eq 'Hexaflexagon'
      expect(@i['license']).to eq 'Attribution-NonCommercial-ShareAlike'
    end
  end
end