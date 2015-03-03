require 'spec_helper'

module Purdie
  module Services
    describe Vimeo do
      before :each do
        @v = Vimeo.new Config.new
      end

      it 'gets a video', :vcr do
        expect(@v.get_video 'https://vimeo.com/117102891').to be_a Hash
      end

      it 'refines a video', :vcr do
        expect(@v.refine 'https://vimeo.com/117102891').to eq({
          "title"=>"Bernard",
          "id"=>117102891,
          "license"=>"Attribution-NonCommercial-ShareAlike",
          "license_url"=>"http://creativecommons.org/licenses/by-nc-sa/3.0/"
        })
      end
    end
  end
end
