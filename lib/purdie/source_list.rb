require 'purdie'

module Purdie
  class SourceList
    include Enumerable

    def initialize sources
      s = sources
      s = [sources] unless sources.class == Array
      @sources = []
      s.each do |source|
        case source
          when /sets/
            @sources += SourceList.resolve_set source
          else
            @sources.push source
        end
      end

      @sources.select! { |i| i !~ /^#/ }
      @sources.uniq! { |item| Purdie.strip_scheme item }
    end

    def [] key
      @sources[key]
    end

    def each &block
      @sources.each do |source|
        if block_given?
          block.call source
        else
          yield source
        end
      end
    end

    def self.from_file source_file
      SourceList.new File.readlines(source_file).map { |l| l.strip }
    end

    def self.resolve_set source
      Ingester.ingesters.select { |service| source =~ /#{service.matcher}/ }[0].resolve_set source
    end
  end
end
