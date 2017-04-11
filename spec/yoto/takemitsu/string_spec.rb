require "spec_helper"

describe "Yoto::Takemitsu::String" do
  describe "delicate_byte_size" do
    it "should multiple 2 when only em string" do
      expect("私は、わたるです。".delicate_byte_size).to eq(18)
    end

    it "should multiple 2 if string is in em space" do
      expect("私は　わたるです。".delicate_byte_size).to eq(18)
    end

    it "should num * 1 when only 1byte string" do
      expect("wataru0225".delicate_byte_size).to eq(10)
    end

    it "should num * 1 if string is in half size space" do
      expect("My name is wataru".delicate_byte_size).to eq(17)
    end
  end

  describe "reduce_emoji" do
    it "should delete emoji" do
      expect("Im very angry!😡".reduce_emoji).to eq("Im very angry!")
    end
  end
end
