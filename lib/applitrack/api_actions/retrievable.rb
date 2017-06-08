module Applitrack
  module ApiActions
    module Retrievable

      # requests object based on ID from API
      def retrieve(id)
        response = Applitrack.client.send_request(self.retrievable_endpoint(id))
        parser = Util::ResponseParser.new(self.object_root)
        self.initialize_object(parser.parse(response.body))
      end

      # alters object endpoint to use passed in ID
      def retrievable_endpoint(id)
        self.endpoint.gsub(/\(\)$/, "(#{id})")
      end

      # initializes object with response data from API
      def initialize_object(response_object)
        self.new(response_object[0])
      end

    end
  end
end
