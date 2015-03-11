module Purdie
  class ResultsSet
    def initialize
      @results = {}
    end

    def [] key
      @results[key]
    end

    def []= key, value
      @results[key] = value
    end

    def to_yaml
      @results.to_yaml
    end
  end
end
