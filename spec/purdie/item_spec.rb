require 'spec_helper'

module Purdie
  describe Item do
    let(:i) {
      Item.new 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
    }

    it 'has a URL' do
      expect(i.url).to eq 'https://soundcloud.com/rawfunkmaharishi/hexaflexagon-1'
    end

    it 'stores datas' do
      i['license'] = 'cc-by-sa'
      expect(i['license']).to eq 'cc-by-sa'
    end

    it 'presents YAML' do
      i['drums'] = 'Purdie'
      i['bass'] = 'Rainey'

      expect(i.to_yaml).to eq (
"---
drums: Purdie
bass: Rainey
"
      )
    end

    it 'knows what service it belongs to' do
      expect(i.service.class).to eq Purdie::Services::SoundCloud
    end

    it 'populates itself', :vcr do
      i.distill
      expect(i['title']).to eq 'Hexaflexagon'
      expect(i['license']).to eq 'Attribution-NonCommercial-ShareAlike'
    end
  end
end
