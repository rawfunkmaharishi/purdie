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
      services = @config['services'].keys.map { |s| "Purdie::Services::#{s}".constantize.new(@config)}

      @sources.each do |source|
        File.readlines(source).each do |line|
          next if line[0] == '#'

          begin
            print "Processing #{line.strip}... "
            services.select{ |s| line =~ /#{s.subconfig['matcher']}/ }[0].ingest line
          rescue NoMethodError => nme
            puts 'unrecognised URL' if nme.message == "undefined method `ingest' for nil:NilClass"
          else
            puts 'done'
          end
        end
      end

      services.map { |service| service.write }
    end
  end
end
