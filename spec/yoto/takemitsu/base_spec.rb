require "spec_helper"

describe "Yoto::Takemitsu::Base" do
  describe "uniq_merge" do
    it "should calculate based on keys and values" do
      object = [
        { name: "morita", money: 1000, count: 1 },
        { name: "morita", money: 1500, count: 1 },
        { name: "tanaka", money: 2000, count: 1 },
        { name: "suzuki", money: 5000, count: 1 },
        { name: "suzuki", money: 5000, count: 1 },
        { name: "fukawa", money: 9000, count: 1 },
        { name: "suzuki", money: 8000, count: 1 },
        { name: "akashi", money: 1000, count: 1 },
      ]
      expected = [
        { name: "morita", money: 2500, count: 2 },
        { name: "tanaka", money: 2000, count: 1 },
        { name: "suzuki", money: 18_000, count: 3 },
        { name: "fukawa", money: 9000, count: 1 },
        { name: "akashi", money: 1000, count: 1 },
      ]
      result = Yoto::Takemitsu::Base.new(object).uniq_merge do
        keys :name
        values :money, :count
      end
      expect(result).to eq(expected)
    end
  end

  describe "original_sort" do
    it "should get decided sorted object" do
      object = [
        { name: "akashi", message: "Are " },
        { name: "fukawa", message: "Best " },
        { name: "morita", message: "We " },
        { name: "suzuki", message: "The " },
        { name: "tanaka", message: "Friends." },
      ]
      expected = [
        { name: "morita", message: "We " },
        { name: "akashi", message: "Are " },
        { name: "suzuki", message: "The " },
        { name: "fukawa", message: "Best " },
        { name: "tanaka", message: "Friends." },
      ]
      result = Yoto::Takemitsu::Base.new(object).original_sort do
        key :name
        order :morita, :akashi, :suzuki, :fukawa, :tanaka
      end
      expect(result).to eq(expected)
    end
  end

  describe "get_by_original_sort" do
    it "should get string based on decided order" do
      object = [
        { name: "akashi", message: "Are " },
        { name: "fukawa", message: "Best " },
        { name: "morita", message: "We " },
        { name: "suzuki", message: "The " },
        { name: "tanaka", message: "Friends." },
      ]
      expected = "We Are The Best Friends."
      result = Yoto::Takemitsu::Base.new(object).get_by_original_sort do
        key :name
        order :morita, :akashi, :suzuki, :fukawa, :tanaka
        value :message
      end
      expect(result).to eq(expected)
    end
  end
end
