module Freesound
  module Collections
    class Base < ActiveResource::Collection
      def initialize(parsed={})
        @elements = parsed.fetch(collection_key)
      end
    end

    class Sounds < Base
      def collection_key
        "sounds"
      end
    end

    class Packs < Base
      def collection_key
        "packs"
      end
    end
  end
end
