require 'purdie'

module Purdie
  class SourceList
    attr_accessor :filename

    include Enumerable

    def initialize sources
      @sources = [sources].
        flatten.
        select { |i| i !~ /^#/ }.
        map { |source| SourceList.resolve source }.
        flatten.
        uniq { |item| Purdie.strip_scheme item }
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
      sl = SourceList.new File.readlines(source_file).map { |l| l.strip }
      sl.filename = File.basename source_file

      sl
    end

    def self.resolve source
      service_class = Ingester.ingesters.select { |service| source =~ /#{service.matcher}/ }[0]
      return [] unless service_class
      service_class.resolve source
    end
  end
end
