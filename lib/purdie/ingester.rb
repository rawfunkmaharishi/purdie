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
  end
end
