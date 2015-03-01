require 'purdie'

module Purdie
  class Config
    def initialize
      @conf = YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', 'config/defaults.yaml')

      if File.exists? File.join(File.dirname(__FILE__), '..', '..', 'config/purdie.yaml')
        y = YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', 'config/purdie.yaml')
        @conf.deep_merge! y
      end
    end

    def [] key
      @conf[key]
    end
  end
end
