require "freesound/response"
require "http"
require "json"

module Freesound
  class Deserializer < HTTP::MimeType::JSON
    def decode(str)
      ::JSON.parse(str, object_class: Response).to_struct
    end

    HTTP::MimeType.register_adapter "application/json", self
  end
end
