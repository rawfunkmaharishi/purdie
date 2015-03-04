require 'purdie'

module Purdie
  class Config
    def initialize
      @conf = YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', '_config/defaults.yaml')

      if File.exists? '_config/purdie.yaml'
        y = YAML.load File.read '_config/purdie.yaml'
        @conf.deep_merge! y
      end
    end

    def [] key
      @conf[key]
    end

    def []= key, value
      @conf[key] = value
    end
  end
end
