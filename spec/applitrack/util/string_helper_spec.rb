require 'applitrack/util/string_helper'

module Applitrack
  module Util
    describe StringHelper do
      subject(:helper) { StringHelper }

      describe ".underscore" do
        it "should convert camelcase to underscored" do
          expect(helper.underscore("SomeThingCool")).to eq("some_thing_cool")
        end
      end

    end
  end
end
