require 'nokogiri'

module Applitrack
  module Util
    class ResponseParser

      def initialize(object_root)
        @object_root = object_root
      end

      def parse(xml_string)
        doc = Nokogiri::XML(xml_string)
        doc.css(@object_root).map do |object|
          extract_attributes(object)
        end
      end

      def extract_attributes(object)
        object.elements.first.elements.inject({}) do |summ, element|
          element_name = format_value(element.name)
          summ[element_name] = element.text
          summ
        end
      end

      def format_value(value)
        StringHelper.underscore(value)
      end

    end
  end
end
