Dotenv.load

module Purdie
  module Ingester
    attr_reader :config, :subconfig, :matcher

    INGESTERS = []

    def self.included base
      # Voodoo: http://stackoverflow.com/questions/10692961/inheriting-class-methods-from-mixins
      base.extend ClassMethods
      INGESTERS.push base
    end

    def self.ingesters
      INGESTERS
    end

    def initialize config
      @config = config
      @items = []

      configure
    end

    def configure
      @output_file = "#{Purdie.basename(self).downcase}.yaml"
      specific_config = @config['services'][Purdie.basename self] rescue nil

      if specific_config
        if specific_config['output_file']
          @config['output_dir'] = File.dirname(specific_config['output_file'])
          @output_file = File.basename(@config['services'][Purdie.basename self]['output_file'])
        end

        specific_config.each_pair do |key, value|
          next if key == 'output_file'
          self.instance_variable_set("@#{key}", value)
        end
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

    module ClassMethods
      def resolve url
        [url]
      end
    end
  end
end
