require 'purdie'

module Purdie
  class Config
    def initialize config_file = nil
      @conf = YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', 'config/defaults.yaml')

      if config_file
        @conf = @conf.deep_merge YAML.load File.read config_file
      end
    end

    def [] key
      @conf[key]
    end
  end
end
