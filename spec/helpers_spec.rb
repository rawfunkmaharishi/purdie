require 'spec_helper'

module Purdie
  describe Bernard do
    it 'strips a scheme' do
      expect(Purdie.strip_scheme 'http://foo.bar/stuff').to eq 'foo.bar/stuff'
      expect(Purdie.strip_scheme 'https://bar.foo/stuff').to eq 'bar.foo/stuff'
    end

    it 'sanitises a URL' do
      expect(Purdie.sanitise_url 'http://foo.bar/stuff/').to eq 'http://foo.bar/stuff'
    end

    it 'gets an id' do
      expect(Purdie.get_id 'http://foo.bar/654321').to eq 654321
      expect(Purdie.get_id 'https://www.youtube.com/watch?v=JCix1XW329g').to eq 'JCix1XW329g'
    end

    it 'gets a basename for a class' do
      module Medeski
        module Martin
          class Wood
          end
        end
      end

      @mmw = Medeski::Martin::Wood.new
      expect(Purdie.basename @mmw).to eq 'Wood'
    end
  end
end
