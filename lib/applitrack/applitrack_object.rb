module Applitrack
  class ApplitrackObject

    class << self

      def endpoint
        ""
      end

      # XML path to each individual Position object within response
      def object_root
        "entry content"
      end

      # acceptable list filters for base object
      def list_filters
        {}
      end

    end

    # set methods and values for class dependent on data hash
    def initialize(data={})
      set_readers(data)
    end

    def metaclass
      class << self; self; end
    end

    # turns each key within data hash to method equivalent to value for that key
    def set_readers(data)
      data.each do |(k,v)|
        metaclass.instance_eval do
          method_value = v
          define_method(k) { method_value }
        end
      end
    end

  end
end
