require 'purdie'

module Purdie
  class SourceList
    include Enumerable

    def initialize sources
      s = sources
      s = [sources] unless sources.class == Array
      s.select! { |i| i !~ /^#/ }

      @sources = []
      s.each do |source|
        @sources += SourceList.resolve_set source
      end

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
      service_class = Ingester.ingesters.select { |service| source =~ /#{service.matcher}/ }[0]
      return [] unless service_class
      service_class.resolve_set source
    end
  end
end
