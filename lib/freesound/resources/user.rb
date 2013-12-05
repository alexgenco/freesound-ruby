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
          response = get(:sounds, {api_key: Freesound.api_key})
          response["sounds"].map { |attrs| Sound.new(attrs) }
        end
      end

      def packs(refresh=false)
        @packs = nil if refresh

        @packs ||= begin
          response = get(:packs, {api_key: Freesound.api_key})
          response["packs"].map { |attrs| Pack.new(attrs) }
        end
      end
    end
  end
end
