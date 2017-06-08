require 'applitrack'
require 'applitrack/applitrack_client'

module Applitrack
  describe ApplitrackClient do
    subject(:client) { ApplitrackClient.new }

    def set_credentials(client_code, username, password)
      Applitrack.client_code = client_code
      Applitrack.username = username
      Applitrack.password = password
    end

    describe "#send_request" do
      before do
        set_credentials('something', 'yo', 'yoyo')
      end

      class InvalidResponse
        attr_reader :message, :code

        def initialize(message, code)
          @message = message
          @code = code
        end
      end

      context "if invalid response" do
        context "due to 500" do
          let(:invalid_response) { OpenStruct.new() }

          before { allow_any_instance_of(Net::HTTP).to receive(:request).and_return(InvalidResponse.new('Internal Server Error', '500')) }

          it "should throw ApiError" do
            expect {
              client.send_request("sup")
            }.to raise_error(ApiError)
          end
        end

      end

    end

    describe "#verify_credentials!" do

      context "when client_code not set" do
        before { set_credentials('', '1', '1') }

        it "should raise an AuthenticationError" do
          expect{ client.verify_credentials! }.to raise_error(Applitrack::AuthenticationError)
        end
      end

      context "when username not set" do
        before { set_credentials('1', '1', '') }

        it "should raise an AuthenticationError" do
          expect{ client.verify_credentials! }.to raise_error(Applitrack::AuthenticationError)
        end
      end

      context "when password not set" do
        before { set_credentials('1', '1', '') }

        it "should raise an AuthenticationError" do
          expect{ client.verify_credentials! }.to raise_error(Applitrack::AuthenticationError)
        end
      end
    end

  end
end
