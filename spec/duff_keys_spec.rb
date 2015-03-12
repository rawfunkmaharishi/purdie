require 'spec_helper'

module Purdie
  module Services
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
  end
end
