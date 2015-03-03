module Purdie
  module Ingester
    def ingest url
      @items.push distill url
    end

    def [] key
      @items[key]
    end

    def has_items?
      @items.count > 0
    end

    def to_yaml
      @items.to_yaml
    end

    def write
      if self.has_items?
        FileUtils.mkdir_p @config['output-dir']

        f = File.open "#{@config['output-dir']}/#{@config['services'][self.class.name.split('::')[-1]]['output-file']}", 'w'
        f.write self.to_yaml
        f.close
      end
    end
  end
end
