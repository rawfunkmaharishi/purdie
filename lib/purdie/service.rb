Dotenv.load

module Purdie
  module Service
    class << self
      attr_reader :services
    end

    @services = []

    def self.included base
      # Voodoo: http://stackoverflow.com/questions/10692961/inheriting-class-methods-from-mixins
      base.extend ClassMethods
      @services.push base
    end

    def initialize config = nil
      config = Config.instance.config unless config
      @config = config

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

    module ClassMethods
      def resolve url
        [url]
      end
    end
  end
end
