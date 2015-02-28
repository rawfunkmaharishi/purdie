require 'purdie'

module Purdie
  class Bernard
    attr_reader :config

    def initialize config_file = nil
      @config = Config.new config_file
    end

    def fetch
      s = Purdie::Services::SoundCloud.new @config
      sounds = []

      sources = Dir.entries(@config['source-dir']).select { |e| e !~ /^\./ }
      sources.each do |source|
        lines = File.readlines "#{@config['source-dir']}/#{source}"
        lines.each do |line|
          case line
            when /soundcloud/
              sounds.push s.refine line
          end
        end
      end

      FileUtils.mkdir @config['output-dir']
      sf = File.open '_data/sounds.yaml', 'w'
      sf.write sounds.to_yaml
      sf.close
    end
  end
end
