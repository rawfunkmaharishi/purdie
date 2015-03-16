require 'spec_helper'

module Purdie
  module Services
    describe Flickr do
      after :each do
        reset_env
        FlickRaw.api_key = ENV['FLICKR_API_KEY']
        FlickRaw.shared_secret = ENV['FLICKR_SECRET']
      end

      it 'responds usefully in the face of no credentials' do
        FlickRaw.api_key = nil
        FlickRaw.shared_secret = nil
        f = Flickr.new Config.new
        expect { f.distill 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.message).to eq 'Flickr credentials missing'
        }
      end

      it 'responds usefully in the face of duff credentials' do
        FlickRaw.api_key = 'abc'
        FlickRaw.shared_secret = '123'
        f = Flickr.new Config.new
        expect { f.distill 'https://www.flickr.com/photos/rawfunkmaharishi/15631479625/' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.message).to eq 'Flickr credentials might be duff'
        }
      end
    end

    describe SoundCloud do
      after :each do
        reset_env
      end

      it 'responds usefully in the face of no credentials' do
        unset_env
        s = SoundCloud.new Config.new
        expect { s.distill 'https://soundcloud.com/rawfunkmaharishi/bernard' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.message).to eq 'SoundCloud credentials missing'
        }
      end

      it 'responds usefully in the face of duff credentials' do
        randomise_env
        s = SoundCloud.new Config.new
        expect { s.distill 'https://soundcloud.com/rawfunkmaharishi/bernard' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.message).to eq 'SoundCloud credentials might be duff'
        }
      end
    end

    describe Vimeo do
      after :each do
        reset_env
      end

      it 'responds usefully in the face of no credentials' do
        unset_env
        v = Vimeo.new Config.new
        expect { v.distill 'https://vimeo.com/111356018' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.message).to eq 'Vimeo credentials missing and/or duff'
        }
      end

      it 'responds usefully in the face of duff credentials' do
        randomise_env
        v = Vimeo.new Config.new
        expect { v.distill 'https://vimeo.com/111356018' }.to raise_exception { |e|
          expect(e).to be_a Purdie::CredentialsException
          expect(e.message).to eq 'Vimeo credentials missing and/or duff'
        }
      end
    end
  end
end
