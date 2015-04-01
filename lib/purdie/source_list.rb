require 'purdie'

module Purdie
  class SourceList
    include Enumerable

    attr_reader :items
    attr_accessor :parent_file

    def initialize sources
      @sources = Resolver.resolve(sources).map { |item| Item.new item }
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

    def process
      bad_creds = []
      bad_licenses = {}
      @items = []
      @sources.each do |source|
        begin
          source.distill
        rescue Purdie::CredentialsException => ce
          bad_creds.push Purdie.basename(ce.service)
        end
        @items.push source

        if bad_creds.any?
          raise Purdie::CredentialsException.new self, "Missing or duff credentials for: #{bad_creds.uniq.join ', '}"
        end
      end
    end

    def write
      process

      FileUtils.mkdir_p File.dirname output_file
      File.open output_file, 'w' do |f|
        dump = @items.map { |item| item.datas }
        f.write dump.to_yaml
      end
    end

    def output_file
      base = File.basename(parent_file).split '.'
      base.push nil if base.count == 1
      base[-1] = 'yaml'

      File.join ['_data', base.join('.')]
    end

    def self.from_file source_file
      sl = SourceList.new File.readlines(source_file).map { |l| l.strip }.select { |i| i !~ /^#/ }
      sl.parent_file = source_file

      sl
    end
  end
end
