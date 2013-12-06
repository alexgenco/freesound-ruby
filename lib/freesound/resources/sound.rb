module Freesound
  module Resources
    class Sound < Base
      self.collection_parser = "Freesound::Collections::Sounds"
    end
  end
end
