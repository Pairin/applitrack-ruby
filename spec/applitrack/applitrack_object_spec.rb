require 'applitrack/applitrack_object'

module Applitrack
  describe ApplitrackObject do

    describe "#set_readers" do
      let(:init_hash) {
        {
          "a" => Random.rand(10),
          "b" => Random.rand(10),
          "c" => Random.rand(10)
        }
      }

      let(:object) { ApplitrackObject.new(init_hash) }

      it "should set methods for each key in hash received during initialization" do
        expect(object.methods).to include(:a)
        expect(object.methods).to include(:b)
        expect(object.methods).to include(:c)
      end

      it "should set values for each value in hash received during initialization" do
        init_hash.keys.each do |k|
          expect(object.send(k)).to eq(init_hash[k])
        end
      end
    end


  end
end
