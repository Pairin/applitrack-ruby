require 'applitrack/api_actions/list'

module Applitrack
  module ApiActions
    RSpec.shared_examples "a list object" do

      describe ".list" do
        let(:response_stub) { Struct.new(:body) }
        let(:id) { Random.rand(10) }

        before do
          allow(described_class).to receive(:initialize_list).and_return([])
          allow_any_instance_of(ApplitrackClient).to receive(:send_request).and_return(response_stub.new(""))
        end

        it "Client should receive #send_request with .endpoint_with_opts" do
          endpoint = described_class.endpoint_with_opts({})
          expect(Applitrack.client).to receive(:send_request).with(endpoint).and_return(response_stub.new(""))
          described_class.list
        end

        it "ResponseParser should receive parse with response body" do
          expect_any_instance_of(Util::ResponseParser).to receive(:parse)
          described_class.list
        end

        it "should pass response into .initialize_list" do
          expect(described_class).to receive(:initialize_list)
          described_class.list
        end


      end

      describe ".initialize_list" do
        let(:list) { (Random.rand(10)+1).times.map{|i| {id: i} } }

        it 'should initialize class for each entry in array' do
          expect(described_class).to receive(:new).exactly(list.count).times
          described_class.initialize_list(list)
        end
      end

      describe ".endpoint_with_opts" do
        context 'when opts is empty' do
          let(:opts) { {} }

          it "should return .endpoint" do
            expect(described_class.endpoint_with_opts(opts)).to eq(described_class.endpoint)
          end
        end

        context "when opts has values" do
          let(:opts) { {a: 1} }

          it "should call .attach_opts_to_endpoint" do
            expect(described_class).to receive(:attach_opts_to_endpoint).with(opts)
            described_class.endpoint_with_opts(opts)
          end
        end
      end

      describe ".attach_opts_to_endpoint" do
        context "if opts doesn't have any keys within .list_filters" do
          let(:opts) { {a: '1'} }

          it "should return .endpoint" do
            expect(described_class.attach_opts_to_endpoint(opts)).to eq(described_class.endpoint)
          end
        end

        context "if opts contains keys within .list_filters" do
        end
      end

      describe ".prepare_value" do
        context "if value is not fixnum" do
          let(:values) { ["", 1.0, true, {}, []] }

          it "should return value" do
            values.each do |v|
              expect(described_class.prepare_value(v)).to eq(v)
            end
          end
        end

        context "if value is fixnum" do
          it "should quote it" do
            num = Random.rand(10)
            expect(described_class.prepare_value(num)).to eq("\'#{num}\'")
          end
        end

      end

    end
  end
end
