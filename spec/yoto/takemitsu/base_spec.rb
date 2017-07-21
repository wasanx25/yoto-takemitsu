require "spec_helper"

describe "Yoto::Takemitsu::Base" do
  describe "uniq_merge" do
    def base_object
      [
        { name: "morita", money: 1000, count: 1 },
        { name: "morita", money: 1500, count: 1 },
        { name: "tanaka", money: 2000, count: 1 },
        { name: "suzuki", money: 5000, count: 1 },
        { name: "suzuki", money: 5000, count: 1 },
        { name: "fukawa", money: 9000, count: 1 },
        { name: "suzuki", money: 8000, count: 1 },
        { name: "akashi", money: 1000, count: 1 },
      ]
    end

    it "should calculate based on keys and values" do
      expected = [
        { name: "morita", money: 2500, count: 2 },
        { name: "tanaka", money: 2000, count: 1 },
        { name: "suzuki", money: 18_000, count: 3 },
        { name: "fukawa", money: 9000, count: 1 },
        { name: "akashi", money: 1000, count: 1 },
      ]
      result = Yoto::Takemitsu::Base.new(base_object).uniq_merge do
        keys :name
        values :money, :count
      end
      expect(result).to eq(expected)
    end

    it "should set keys and values" do
      expect {
        Yoto::Takemitsu::Base.new(base_object).uniq_merge {}
      }.to raise_error("you should set keys and values")
    end
  end

  describe "original_sort" do
    def base_object
      [
        { name: "akashi", message: "Are " },
        { name: "fukawa", message: "Best " },
        { name: "morita", message: "We " },
        { name: "suzuki", message: "The " },
        { name: "tanaka", message: "Friends." },
      ]
    end

    it "should get decided sorted object" do
      expected = [
        { name: "morita", message: "We " },
        { name: "akashi", message: "Are " },
        { name: "suzuki", message: "The " },
        { name: "fukawa", message: "Best " },
        { name: "tanaka", message: "Friends." },
      ]
      result = Yoto::Takemitsu::Base.new(base_object).original_sort do
        key :name
        order :morita, :akashi, :suzuki, :fukawa, :tanaka
      end
      expect(result).to eq(expected)
    end

    it "should set key and order" do
      expect {
        Yoto::Takemitsu::Base.new(base_object).original_sort {}
      }.to raise_error("you should set key and order")
    end
  end

  describe "get_by_original_sort" do
    def base_object
      [
        { name: "akashi", message: "Are " },
        { name: "fukawa", message: "Best " },
        { name: "morita", message: "We " },
        { name: "suzuki", message: "The " },
        { name: "tanaka", message: "Friends." },
      ]
    end

    it "should get string based on decided order" do
      expected = "We Are The Best Friends."
      result = Yoto::Takemitsu::Base.new(base_object).get_by_original_sort do
        key :name
        order :morita, :akashi, :suzuki, :fukawa, :tanaka
        value :message
      end
      expect(result).to eq(expected)
    end

    it "should set key and order" do
      expect {
        Yoto::Takemitsu::Base.new(base_object).get_by_original_sort {}
      }.to raise_error("you should set key and order and value")
    end
  end
end
