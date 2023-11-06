require 'rails_helper'

RSpec.describe Attack do
  before :each do
    attack_info = {name: "Melee Attack",
                   attack_bonus: 8,
                   damage: [{damage_dice: "2d6+5"}, {damage_dice: "1d8"}]}
    @attack = Attack.new(attack_info)
  end

  it "has readable attributes" do
    expect(@attack).to be_an Attack
    expect(@attack.name).to be_a String
    expect(@attack.hit_bonus).to be_a Integer
    expect(@attack.damage_dice).to be_an Array
  end

  it "#max_damage" do
    expect(@attack.max_damage).to eq(25)
  end
  
end