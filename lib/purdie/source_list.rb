require 'purdie'

module Purdie
  class SourceList
    include Enumerable

    def initialize sources
      @sources = sources
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
  end
end
