module Freesound
  module Resources
    class Pack < Base
      self.collection_parser = "Freesound::Collections::Packs"

      def sounds(refresh=false)
        @sounds = nil if refresh

        @sounds ||= begin
          path = URI.parse(super).path
          Sound.find(:all, from: path, params: query_params)
        end
      end
    end
  end
end
