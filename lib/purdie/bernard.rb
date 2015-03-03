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

      v = Purdie::Services::Vimeo.new @config
      vimeos = []

      sources = Dir.entries(@config['source-dir']).select { |e| e !~ /^\./ }
      sources.each do |source|
        lines = File.readlines "#{@config['source-dir']}/#{source}"
        lines.each do |line|
          case line
            when /soundcloud/
              sounds.push s.refine line

            when /flickr/
              flickrs.push f.refine line

            when /vimeo/
              vimeos.push v.refine line
          end
        end
      end

      FileUtils.mkdir_p @config['output-dir']

      sf = File.open "#{@config['output-dir']}/#{@config['services']['SoundCloud']['output-file']}", 'w'
      sf.write sounds.to_yaml
      sf.close

      ff = File.open "#{@config['output-dir']}/#{@config['services']['Flickr']['output-file']}", 'w'
      ff.write flickrs.to_yaml
      ff.close

      vf = File.open "#{@config['output-dir']}/#{@config['services']['Vimeo']['output-file']}", 'w'
      vf.write vimeos.to_yaml
      vf.close
    end
  end
end
