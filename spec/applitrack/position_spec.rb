require 'applitrack/position'

module Applitrack
  describe Position do
    it_behaves_like "a list object"
    it_behaves_like "a retrievable object"

    describe ".endpoint" do
      it "should be correct" do
        expect(Position.endpoint).to eq("Positions()")
      end
    end

  end
end
