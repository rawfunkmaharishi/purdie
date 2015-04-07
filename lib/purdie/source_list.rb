module Purdie
  class SourceList
    include Enumerable

    attr_reader :items
    attr_accessor :parent_file, :verbose

    def initialize sources
      @sources = Resolver.resolve(sources).map { |item| Item.new item }
      @items = []
      @bad_creds = []
      @bad_licenses = {}
    end

    def [] key
      @sources[key]
    end

    def each
      @sources.each do |source|
        yield source
      end
    end

    def process
      @sources.each do |source|
        begin
          print "Processing #{source.url}... " if @verbose
          source.distill
          puts 'done' if @verbose
        rescue Purdie::CredentialsException => ce
          @bad_creds.push Purdie.basename(ce.service)
          puts 'fail' if @verbose
        rescue Purdie::LicenseException => le
          @bad_licenses[Purdie.basename le.service].push le.name rescue @bad_licenses[Purdie.basename le.service] = [le.name]
          puts 'fail' if @verbose
        end
        @items.push source

        bad_credentials?
        bad_licenses?
      end
    end

    def bad_credentials?
      if @bad_creds.any?
        raise Purdie::CredentialsException.new self, "Missing or duff credentials for: #{@bad_creds.uniq.join ', '}"
      end
    end

    def bad_licenses?
      if @bad_licenses.any?
        bad = @bad_licenses.map { |k,v| "#{k}: #{v.uniq.join ', '}" }.join '; '
        message = "Unknown licenses: #{bad}"
        message += "\n"
        message += 'Please consider adding the details for these licenses at https://github.com/rawfunkmaharishi/purdie/blob/master/_config/licenses.yaml'
        raise Purdie::PurdieException.new message
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

    def self.from_file source_file, verbose = nil
      sl = SourceList.new File.readlines(source_file).map { |l| l.strip }.select { |i| i !~ /^#/ }
      sl.parent_file = source_file
      sl.verbose = verbose
      sl
    end
  end
end
