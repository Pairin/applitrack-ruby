require 'applitrack/api_actions/retrievable'

module Applitrack
  module ApiActions
    RSpec.shared_examples "a retrievable object" do

      describe ".retrieve" do
        let(:response_stub) { Struct.new(:body) }
        let(:id) { Random.rand(10) }

        before do
          allow(described_class).to receive(:initialize_object).and_return({})
          allow_any_instance_of(ApplitrackClient).to receive(:send_request).and_return(response_stub.new(""))
        end

        it "Client should receive #send_request with .retrievable_endpoint" do
          endpoint = described_class.retrievable_endpoint(id)
          expect(Applitrack.client).to receive(:send_request).with(endpoint).and_return(response_stub.new(""))
          described_class.retrieve(id)
        end

        it "ResponseParser should receive parse with response body" do
          expect_any_instance_of(Util::ResponseParser).to receive(:parse)
          described_class.retrieve(id)
        end

        it "should pass response into .initialize_object" do
          expect(described_class).to receive(:initialize_object)
          described_class.retrieve(id)
        end

      end

      describe ".retrievable_endpoint" do
        it "should return endpoint with passed in value within parens" do
          normal_endpoint = described_class.endpoint
          id = Random.rand(10)
          expected_endpoint = described_class.endpoint[0..-2]+"#{id})"
          expect(described_class.retrievable_endpoint(id)).to eq(expected_endpoint)
        end
      end

      describe ".initialize_object" do
        let(:params) { [{a: '1', b: '2', c: '3'}] }

        it "should initialize new object of described class with params" do
          expect(described_class).to receive(:new).with(params[0])
          described_class.initialize_object(params)
        end
      end

    end
  end
end
