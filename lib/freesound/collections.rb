require "active_resource"

module Freesound
  module Collections
    # Collections are required to tell ActiveResource how to parse JSON
    # responses that wrap a collection of resources.
    #
    # The #collection_key method provides the JSON key that will contain the
    # resource data.
    #
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
