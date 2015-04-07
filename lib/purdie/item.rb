module Purdie
  class Item
    attr_reader :url, :datas

    def initialize url
      @url = url
      @datas = {}
    end

    def distill
      @datas = service.distill @url
    end

    def []= key, value
      @datas[key] = value
    end

    def [] key
      @datas[key]
    end

    def service
      c = Service.services.select { |s| url =~ /#{s.matcher}/ }.first
      c.new
    end

    def to_yaml
      Purdie.debug 'wtf'
      @datas.to_yaml
    end
  end
end
