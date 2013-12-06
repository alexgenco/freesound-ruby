require "active_resource"
require "uri"

require "freesound/collections"

module Freesound
  module Resources
    class Base < ActiveResource::Base
      self.site = "http://www.freesound.org/api"
      self.include_format_in_path = false

      class << self
        # The Freesound API requires URLs to have a trailing slash before their
        # query parameters, otherwise the request will result in a redirect.
        #
        # These are hacks to construct the URLs correctly because ActiveResource
        # does not append a trailing slash.
        #
        def element_path(id, *args)
          super("#{id}/", *args)
        end

        def get(path, *args)
          super("#{path}/", *args)
        end

        # Macro for establishing relationships.
        #
        # Resources return has_many relationships as a URL, rather than a
        # collection of objects. For example user JSON would look like:
        #
        #   {
        #     username: "alexgenco",
        #     sounds: "http://www.freesound.org/api/people/alexgenco/sounds/"
        #   }
        #
        # This macro generates methods to access these child resources by
        # following the URL and instantiating the appropriate resource.
        #
        # To setup a User that has many sounds:
        #
        #   class User
        #     references :sounds
        #   end
        #
        def references(collection_name)
          resource_class = collection_name.to_s.singularize.camelize

          class_eval(<<-RUBY, __FILE__, __LINE__)
            def #{collection_name}(refresh=false)
              @#{collection_name} = nil if refresh

              @#{collection_name} ||= begin
                path = URI.parse(super).path
                #{resource_class}.find(:all, from: path, params: query_params)
              end
            end
          RUBY
        end
      end

      private

      def query_params(additional={})
        {api_key: Freesound.api_key}.merge(additional)
      end
    end

    class User < Base
      self.collection_name = "people"

      references :sounds
      references :packs

      # User resources are identified by their username, for example:
      #
      #   /api/people/alexgenco
      #
      def id
        username
      end
    end

    class Sound < Base
      self.collection_parser = "Freesound::Collections::Sounds"
    end

    class Pack < Base
      self.collection_parser = "Freesound::Collections::Packs"

      references :sounds
    end
  end
end
