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
      services = {}
      @config['services'].each do |s|
        services[s[0].downcase.to_sym] = "Purdie::Services::#{s[0]}".constantize.new(@config)
      end

      @sources.each do |source|
        File.readlines(source).each do |line|
          next if line[0] == '#'

          print "Processing #{line.strip}... "
          services[services.keys.select{ |s| line =~ /#{s.to_s}/ }[0]].ingest line
          puts 'done'
        end
      end

      services.each_key do |k|
        services[k].write
      end
    end
  end
end
