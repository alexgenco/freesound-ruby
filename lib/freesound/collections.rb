require "active_resource"

module Freesound
  module Collections
    # Collections are required to tell ActiveResource how to parse JSON
    # responses that wrap a collection of resources.
    #
    # The #__collection_key method determines the JSON key containing the
    # resource data.
    #
    class Base < ActiveResource::Collection
      def initialize(parsed={})
        @elements = parsed.fetch(__collection_key)
      end

      private

      def __collection_key
        self.class.name.underscore
      end
    end

    class Sounds < Base; end
    class Packs  < Base; end
  end
end
