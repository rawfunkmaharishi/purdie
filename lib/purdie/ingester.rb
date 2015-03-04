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

    def ingest url
      @items.push distill url
    end

    def [] key
      @items[key]
    end

    def has_items?
      @items.count > 0
    end

    def to_yaml
      @items.to_yaml
    end

    def write
      if self.has_items?
        FileUtils.mkdir_p @config['output-dir']

        File.open "#{@config['output-dir']}/#{@output_file}", 'w' do |f|
          f.write self.to_yaml
        end
      end
    end
  end
end
