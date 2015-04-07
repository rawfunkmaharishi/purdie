module Purdie
  class LicenseManager
    LOOKUPS = YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', '_config/licenses.yaml')

    def self.get service, raw_name
      License.new service, raw_name, LOOKUPS[Purdie.basename service][raw_name]
    end
  end

  class License
    def initialize service, raw_name, values
      raise LicenseException.new service, raw_name unless values
      @values = values
    end

    def [] key
      @values[key]
    end

    def method_missing method_name, *args
      mname = method_name.to_s

      if @values.include? mname
        @values[mname]
      else
        raise NoMethodError
      end
    end
  end

  class LicenseException < Exception
    attr_reader :service, :name

    def initialize service, name
      @service = service
      @name = name
    end
  end
end
