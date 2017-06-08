require 'applitrack/application'

module Applitrack
  describe Application do
    it_behaves_like "a list object"
    it_behaves_like "a retrievable object"

    describe ".endpoint" do
      it "should be correct" do
        expect(Application.endpoint).to eq("Applications()")
      end
    end


  end
end
