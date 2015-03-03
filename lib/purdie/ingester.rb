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

        File.open "#{@config['output-dir']}/#{@config['services'][self.class.name.split('::')[-1]]['output-file']}", 'w' do |f|
          f.write self.to_yaml
        end
      end
    end
  end
end
