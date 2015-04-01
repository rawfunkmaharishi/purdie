Dotenv.load

module Purdie
  module Ingester
    attr_reader :config, :subconfig, :matcher

    include Enumerable

    class << self
      attr_reader :ingesters
    end

    @ingesters = []

    def self.included base
      # Voodoo: http://stackoverflow.com/questions/10692961/inheriting-class-methods-from-mixins
      base.extend ClassMethods
      @ingesters.push base
    end

    def initialize config = nil
      config = Config.new unless config
      @config = config
      @items = []

      configure
    end

    def configure
      @output_file = "#{@config['output_dir']}/#{Purdie.basename(self).downcase}.yaml"
      specific_config = @config['services'][Purdie.basename self] rescue nil

      if specific_config
        specific_config.each_pair do |key, value|
          self.instance_variable_set("@#{key}", value)
        end
      end
    end

    def ingest url
      @items.push distill url
    end

    def each
      @items.each do |item|
        yield item
      end
    end

    def [] key
      @items[key]
    end

    def to_yaml
      @items.to_yaml
    end

    def write
      if self.any?
        FileUtils.mkdir_p File.dirname @output_file
        File.open @output_file, 'w' do |f|
          f.write self.to_yaml
        end
      end
    end

    module ClassMethods
      def resolve url
        [url]
      end
    end
  end
end
