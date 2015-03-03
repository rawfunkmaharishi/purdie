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
      flickr = Purdie::Services::Flickr.new @config
      soundcloud = Purdie::Services::SoundCloud.new @config
      vimeo = Purdie::Services::Vimeo.new @config

      @sources.each do |source|
        lines = File.readlines source
        lines.each do |line|
          print "Processing #{line.strip}... "
          case line
            when /soundcloud/
              soundcloud.ingest line

            when /flickr/
              flickr.ingest line

            when /vimeo/
              vimeo.ingest line
          end
          puts 'done'
        end
      end

      flickr.write
      soundcloud.write
      vimeo.write
    end
  end
end
