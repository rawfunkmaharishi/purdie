require 'purdie'

module Purdie
  class Config
    def initialize
      @conf = YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', 'config/defaults.yaml')

      if File.exists? File.join(File.dirname(__FILE__), '..', '..', 'config/purdie.yaml')
        @conf = @conf.deep_merge YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', 'config/purdie.yaml')
      end
    end

    def [] key
      @conf[key]
    end
  end
end
