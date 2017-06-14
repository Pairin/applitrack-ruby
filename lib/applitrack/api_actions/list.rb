module Applitrack
  module ApiActions
    module List

      # request list of objects from API
      def list(opts={})
        response = Applitrack.client.send_request(self.endpoint_with_opts(opts))
        parser = Util::ResponseParser.new(self.object_root)
        self.initialize_list(parser.parse(response.body))
      end

      # initialize each entry within response as an object
      def initialize_list(response_list)
        response_list.map do |list_object|
          self.new(list_object)
        end
      end

      # if opts exist returns .endpoint or calls method to attach accepted params
      def endpoint_with_opts(opts)
        return self.endpoint if opts.empty?
        self.attach_opts_to_endpoint(opts)
      end

      # translates options into class specific API params and attaches to url.
      # if opts don't include any accepted params returns .endpoint unaltered
      def attach_opts_to_endpoint(opts)
        request_endpoint = self.endpoint
        opt_keys = opts.keys

        accepted_opts = self.list_filters.select{|(k,v)| opt_keys.include?(k) }

        if !accepted_opts.empty?
          request_endpoint += "?$filter="
          request_endpoint += (accepted_opts.map do |(k,v)|
            prepared_value = self.prepare_value(opts[k])
            "(#{v.gsub('VALUE', prepared_value)})"
          end.join(" and "))

          request_endpoint
        end

        request_endpoint
      end

      # Quote integers, bools, and strings because Applitrack API is picky
      def prepare_value(value)
        if [TrueClass, FalseClass].include?(value.class) || value.is_a?(Fixnum) || value.match(/^[0-9]+$/)
          value.to_s
        elsif value.is_a?(String)
          "\'#{value}\'"
        end
      end

    end
  end
end
