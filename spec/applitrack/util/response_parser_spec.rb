require 'applitrack/util/response_parser'

module Applitrack
  module Util
    describe ResponseParser do
      let(:object_root) { "entry"}
      subject(:parser) { ResponseParser.new(object_root) }

      let(:objects) do
        (Random.rand(10) + 2).times.map do |i|
          "
            <#{object_root}>
              <id>#{i}</id>
            </#{object_root}>
          "
        end
      end

      let(:xml) {
        "<xml>
          #{objects.join}
        </xml>"
      }

      describe "#parse" do
        it "should pass argument into Nokogiri::XML" do
          parsed_document = Nokogiri::XML(xml)
          expect(Nokogiri::XML::Document).to receive(:parse).and_return(parsed_document)
          parser.parse(xml)
        end

        it "should call #extract_attributes on each object_root" do
          expect(parser).to receive(:extract_attributes).at_least(objects.count).times
          parser.parse(xml)
        end
      end

      describe "#extract_attributes" do
        it "should return object as hash" do
          object_index = Random.rand(objects.count - 1)
          parsed_object = Nokogiri::XML(objects[object_index])
          response = parser.extract_attributes(parsed_object)
          expect(response).to eq({"id" => object_index.to_s})
        end
      end

      describe "#format_value" do
        it "should pass value into StringHelper.underscore" do
          value  = 'underscoreValue'
          expect(StringHelper).to receive(:underscore).with(value)
          parser.format_value(value)
        end
      end


    end
  end
end
