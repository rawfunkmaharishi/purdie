require 'purdie'

module Purdie
  class Bernard
    attr_reader :config

    def initialize
      @config = Config.new
      @sources = Dir.entries(@config['source-dir']).select { |e| e !~ /^\./ }
      @sources.map! { |s| "#{@config['source-dir']}/#{s}"}
    end

    def source_file path
      @sources = [path]
    end

    def fetch
      s = Purdie::Services::SoundCloud.new @config
      soundclouds = []

      f = Purdie::Services::Flickr.new @config
      flickrs = []

      v = Purdie::Services::Vimeo.new @config
      vimeos = []

      @sources.each do |source|
        lines = File.readlines source
        lines.each do |line|
          print "Processing #{line.strip}... "
          case line
            when /soundcloud/
              soundclouds.push s.distill line

            when /flickr/
              flickrs.push f.distill line

            when /vimeo/
              vimeos.push v.distill line
          end
          puts 'done'
        end
      end

      FileUtils.mkdir_p @config['output-dir']

      if soundclouds[0]
        sf = File.open "#{@config['output-dir']}/#{@config['services']['SoundCloud']['output-file']}", 'w'
        sf.write soundclouds.to_yaml
        sf.close
      end

      if flickrs[0]
        ff = File.open "#{@config['output-dir']}/#{@config['services']['Flickr']['output-file']}", 'w'
        ff.write flickrs.to_yaml
        ff.close
      end

      if vimeos[0]
        vf = File.open "#{@config['output-dir']}/#{@config['services']['Vimeo']['output-file']}", 'w'
        vf.write vimeos.to_yaml
        vf.close
      end
    end
  end
end
