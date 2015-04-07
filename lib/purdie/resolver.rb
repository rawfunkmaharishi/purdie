module Purdie
  class Resolver
    def self.resolve urls
      urls = [urls].flatten
      resolved = []

      urls.each do |url|
        service_class = Service.services.select { |service| url =~ /#{service.matcher}/ }[0]
        resolved += service_class.resolve(url) if service_class
      end

      resolved.uniq { |url| Purdie.strip_scheme url }
    end
  end
end
