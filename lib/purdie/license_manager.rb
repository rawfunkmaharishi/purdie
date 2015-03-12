require 'purdie'

module Purdie
  class LicenseManager
    LOOKUPS = YAML.load File.read File.join(File.dirname(__FILE__), '..', '..', '_config/licenses.yaml')

    def self.get raw_name
      License.new raw_name, LOOKUPS[raw_name]
    end
  end

  class License
    def initialize raw_name, values
      raise LicenseException.new "Unknown license type: #{raw_name}" unless values
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
    attr_reader :status

    def initialize status
      @status = status
    end
  end
end
