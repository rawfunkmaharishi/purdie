require 'singleton'

module Purdie
  class Config
    def initialize
      @conf = OpenStruct.new fetch_yaml 'defaults'

      if File.exists? '_config/purdie.yaml'
        @local = OpenStruct.new YAML.load File.read '_config/purdie.yaml'
        @conf = OpenStruct.new (@conf.to_h.deep_merge @local)
      end
    end

    def [] key
      @conf[key]
    end

    def []= key, value
      @conf[key] = value
    end

    private

    def fetch_yaml file
      YAML.load(File.open(File.join(File.dirname(__FILE__), '..', '..', '_config/%s.yaml' % file)))
    end
  end
end
