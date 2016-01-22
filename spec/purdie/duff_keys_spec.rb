require 'spec_helper'

module Purdie
  module Services
    describe Flickr do
      before :each do
        unset_env
      end

      after :each do
        reset_env
        FlickRaw.api_key = ENV['FLICKR_API_KEY']
        FlickRaw.shared_secret = ENV['FLICKR_SECRET']
      end

      it 'responds usefully in the face of no credentials' do
        FlickRaw.api_key = nil
        FlickRaw.shared_secret = nil
        f = Flickr.new
###        expect { f.distill 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/' }.to raise_exception { |e|
###          expect(e).to be_a Purdie::CredentialsException
###          expect(e.message).to eq 'Flickr credentials missing'
###        }
      end

      it 'responds usefully in the face of duff credentials' do
        FlickRaw.api_key = 'abc'
        FlickRaw.shared_secret = '123'
        f = Flickr.new
###        expect { f.distill 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/' }.to raise_exception { |e|
###          expect(e).to be_a Purdie::CredentialsException
###          expect(e.message).to eq 'Flickr credentials might be duff'
###        }
      end
    end

    describe SoundCloud do
      after :each do
        reset_env
      end

      it 'responds usefully in the face of no credentials' do
        unset_env
        s = SoundCloud.new
        expect { s.distill 'https://soundcloud.com/rawfunkmaharishi/bernard' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.service.class).to eq Purdie::Services::SoundCloud
          expect(e.message).to eq 'missing'
        }
      end

      it 'responds usefully in the face of duff credentials' do
        randomise_env
        s = SoundCloud.new
        expect { s.distill 'https://soundcloud.com/rawfunkmaharishi/bernard' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.service.class).to eq Purdie::Services::SoundCloud
          expect(e.message).to eq 'duff'
        }
      end
    end

    describe Vimeo do
      after :each do
        reset_env
      end

      it 'responds usefully in the face of no credentials' do
        unset_env
        v = Vimeo.new
        expect { v.distill 'https://vimeo.com/111356018' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.service.class).to eq Purdie::Services::Vimeo
          expect(e.message).to eq 'missing and/or duff'
        }
      end

      it 'responds usefully in the face of duff credentials' do
        randomise_env
        v = Vimeo.new
          expect { v.distill 'https://vimeo.com/111356018' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.service.class).to eq Purdie::Services::Vimeo
          expect(e.message).to eq 'missing and/or duff'
        }
      end
    end
  end
end
