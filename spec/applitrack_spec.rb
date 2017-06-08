require 'applitrack'


describe Applitrack do
  subject(:applitrack) { Applitrack }

  describe "#client_code=" do
    let(:new_client_code) { Random.rand(1000).to_s }

    before { applitrack.client_code = new_client_code }

    context "when client_code hasn't been set" do

      it "should replace default client code value in @api_base with new value" do
        expect(Applitrack.api_base).to include(new_client_code)
      end
    end

    context "when client_code has been set" do
      let(:replacement_client_code) { Random.rand(1000).to_s + "a" }

      it "should replace old client code in @api_base with new value" do
        applitrack.client_code = replacement_client_code
        expect(applitrack.client_code).to_not include(new_client_code)
        expect(applitrack.client_code).to include(replacement_client_code)
      end
    end
  end

  describe "#client" do
    context "if a client has not been initialized" do
      before { Applitrack.instance_variable_set("@client", nil) }

      it "should initialize an ApplitrackClient" do
        expect(Applitrack::ApplitrackClient).to receive(:new)
        applitrack.client
      end
    end

    context "if a client has been initialied" do
      it "should not initialize a new client" do
        applitrack.client
        expect(Applitrack::ApplitrackClient).to_not receive(:new)
        applitrack.client
      end
    end
  end

  describe "#config=" do
    context "when config has non config specific values" do
      let(:config) { {yo: "yo", whats: "whats", up: "up"} }

      it "should ignore non config based values" do
        config.keys.each do |k|
          expect(applitrack).to_not receive("#{k}=")
        end

        applitrack.config = config
      end
    end

    context "when config has usable values" do
      let(:config) { {client_code: "1", username: "2", password: "3"} }

      it "should set passed in config variables" do
        config.each do |(k,v)|
          expect(applitrack).to receive("#{k}=").with(v)
        end

        applitrack.config = config
      end
    end
  end

end
