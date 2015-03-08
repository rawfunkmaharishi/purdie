require 'purdie'

module Purdie
  class Bernard
    attr_reader :config

    def initialize
      @config = Config.new
      begin
        @sources = Dir.entries(@config['source_dir']).select { |e| e !~ /^\./ }
        @sources.map! { |s| "#{@config['source_dir']}/#{s}"}
      rescue Errno::ENOENT
        @sources = nil
      end
    end

    def source_file= path
      @sources = [path]
    end

    def services
      @services ||= Ingester.includees.map { |i| i.new @config }
    end

    def process list
      list.each do |line|
        next if line[0] == '#'
        next if line == ''

        begin
          print "Processing #{line.strip}... "
          grab line
        rescue NoMethodError => nme
          puts "unrecognised URL [#{line}]" if nme.message == "undefined method `ingest' for nil:NilClass"
        else
          puts 'done'
        end
      end
    end

    def fetch
      raise Exception.new 'No data sources specified' unless @sources

      @sources.each do |source|
        process SourceList.from_file source
      end

      dump
    end

    def grab url
      services.select{ |s| url =~ /#{s.matcher}/ }[0].ingest url
    end

    def dump
      services.map { |service| service.write }
    end
  end
end
