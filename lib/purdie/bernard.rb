require 'purdie'

module Purdie
  class Bernard
    attr_reader :config

    def initialize
      @config = Config.instance.config
      begin
        @sources = Dir.entries(@config['source_dir']).select { |e|
          e !~ /^\./
        }.map { |s|
          "#{@config['source_dir']}/#{s}"
        }
      rescue Errno::ENOENT
        @sources = nil
      end
    end

#    def source_file= path
#      @sources = path
#    end

    def fetch
      raise PurdieException.new 'No data sources specified' unless @sources

      @sources.map { |s| SourceList.from_file s }.each do |source|
        source.write
      end
    end
  end
end
