module Freesound
  module Resources
    class User < Base
      self.collection_name = "people"

      def id
        username
      end

      def sounds(refresh=false)
        @sounds = nil if refresh

        @sounds ||= begin
          path = URI.parse(super).path
          Sound.find(:all, from: path, params: query_params)
        end
      end

      def packs(refresh=false)
        @packs = nil if refresh

        @packs ||= begin
          path = URI.parse(super).path
          Pack.find(:all, from: path, params: query_params)
        end
      end
    end
  end
end
