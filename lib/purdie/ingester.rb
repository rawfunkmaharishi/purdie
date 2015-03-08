Dotenv.load

module Purdie
  module Ingester
    attr_reader :config, :subconfig, :matcher

    INCLUDEES = []

    def self.included base
      INCLUDEES.push base
    end

    def self.includees
      INCLUDEES
    end

    def initialize config
      @config = config
      @items = []

      configure
    end

    def configure
      @output_file = "#{Purdie.basename(self).downcase}.yaml"
      # This still feels like such a hack
      begin
        @config['output_dir'] = File.dirname(@config['services'][Purdie.basename self]['output_file'])
        @output_file = File.basename(@config['services'][Purdie.basename self]['output_file'])
      rescue NoMethodError
      end
    end

    def ingest url
      @items.push distill url
    end

    def [] key
      @items[key]
    end

    def count
      @items.count
    end

    def has_items?
      @items.count > 0
    end

    def to_yaml
      @items.to_yaml
    end

    def write
      if self.has_items?
        FileUtils.mkdir_p @config['output_dir']
        File.open "#{@config['output_dir']}/#{@output_file}", 'w' do |f|
          f.write self.to_yaml
        end
      end
    end
  end
end
