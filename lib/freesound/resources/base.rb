require "active_resource"

module Freesound
  module Resources
    class Base < ActiveResource::Base
      self.site = "http://www.freesound.org/api"
      self.include_format_in_path = false

      # The Freesound API requires URLs to have a trailing slash
      # before their query parameters, otherwise the request will
      # result in a redirect.
      #
      # This is a hack to construct the URLs correctly because
      # ActiveResource does not append a trailing slash.
      def self.element_path(id, *args)
        super("#{id}/", *args)
      end
    end
  end
end
