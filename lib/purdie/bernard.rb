require 'purdie'

module Purdie
  class Bernard
    attr_reader :config

    def initialize
      @config = Config.new
    end

    def fetch
      s = Purdie::Services::SoundCloud.new @config
      sounds = []

      f = Purdie::Services::Flickr.new @config
      flickrs = []

      sources = Dir.entries(@config['source-dir']).select { |e| e !~ /^\./ }
      sources.each do |source|
        lines = File.readlines "#{@config['source-dir']}/#{source}"
        lines.each do |line|
          case line
            when /soundcloud/
              sounds.push s.refine line

            when /flickr/
              flickrs.push f.refine line
          end
        end
      end

      FileUtils.mkdir @config['output-dir']
      sf = File.open '_data/soundcloud.yaml', 'w'
      sf.write sounds.to_yaml
      sf.close

      ff = File.open '_data/flickr.yaml', 'w'
      ff.write flickrs.to_yaml
      ff.close
    end
  end
end
