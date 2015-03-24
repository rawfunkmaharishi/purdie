require 'purdie'

module Purdie
  class Item
    attr_reader :url, :parent_file

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

    def attach_license service, license
      l = Purdie::LicenseManager.get service, license
      @datas['license'] = l['full_name']
      @datas['license_url'] = l['url']
    end

    def service
      c = Ingester.ingesters.select { |s| url =~ /#{s.matcher}/ }.first
      c.new
    end

    def to_yaml
      Purdie.debug 'wtf'
      @datas.to_yaml
    end

    def source_list= source_list
      @parent_file = source_list.parent_file
    end
  end
end
