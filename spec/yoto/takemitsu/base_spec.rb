require "spec_helper"

describe "Yoto::Takemitsu::Base" do
  describe "uniq_merge" do
    it "should calculate based on keys and values" do
      object = [
          {name: 'morita', money: 1000, count: 1},
          {name: 'morita', money: 1500, count: 1},
          {name: 'tanaka', money: 2000, count: 1},
          {name: 'suzuki', money: 5000, count: 1},
          {name: 'suzuki', money: 5000, count: 1},
          {name: 'fukawa', money: 9000, count: 1},
          {name: 'suzuki', money: 8000, count: 1},
          {name: 'akashi', money: 1000, count: 1},
      ]
      expected = [
          {name: "morita", money: 2500, count: 2},
          {name: "tanaka", money: 2000, count: 1},
          {name: "suzuki", money: 18000, count: 3},
          {name: "fukawa", money: 9000, count: 1},
          {name: "akashi", money: 1000, count: 1},
      ]
      result = Yoto::Takemitsu::Base.new(object).uniq_merge do |o|
        o.keys :name
        o.values :money, :count
      end
      expect(result).to eq(expected) 
    end
  end
end

