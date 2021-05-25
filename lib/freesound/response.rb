module Freesound
  class Response
    def initialize
      @attrs = {}
    end

    def []=(key, value)
      @attrs[key.to_sym] = walk_to_struct(value)
    end

    def [](key)
      @attrs[key.to_sym]
    end

    def to_struct
      Struct.new(*@attrs.keys).new(*@attrs.values)
    end

    private

    def walk_to_struct(obj, depth=0)
      if depth >= 10_000
        raise "Response object exceeds maximum depth of #{depth}"
      end

      case obj
      when Array
        obj.map { |elem| walk_to_struct(elem, depth + 1) }
      when Hash
        obj.inject({}) do |acc, (key, value)|
          acc.merge!(key, walk_to_struct(value, depth + 1))
        end
      when Response
        obj.to_struct
      else
        obj
      end
    end
  end
end
