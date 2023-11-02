class Attack
  attr_reader :name

  def initialize(data)
    @name = data[:name]
    @description = data[:desc] if data[:desc]
    @action = data[:actions] if data[:actions]
    @hit_bonus = data[:attack_bonus]
    @saving_throw = {
      type: data[:dc][:name], 
      threshold: data[:dc][:dc_value], 
      success: data[:dc][:success_type]
    } if data[:dc]
    @damage_dice = data[:damage] if data[:damage]
  end

  def max_damage
    @damage_dice.sum do |damage|
      (damage[:damage_dice].split(/[^\d]/)[0].to_i * damage[:damage_dice].split(/[^\d]/)[1].to_i) + damage[:damage_dice].split(/[^\d]/)[3].to_i
    end
  end

  def attack(target)
    if @name == "Multiattack"
      multiattack(target)
    else
      roll = to_hit
      if roll == "Critical Miss"
        "Miss"
      elsif roll == "Critical Hit"
        target.take_damage(roll_crit(@damage_dice))
      elsif roll < target.armor_class
        "Miss"
      else
        target.take_damage(roll_damage(@damage_dice))
      end
    end
  end

  def to_hit
    roll = roll_die
    if roll == 20
      "Critical Hit"
    elsif roll == 1
      "Critical Miss"
    else
      roll + @hit_bonus
    end
  end

  def multiattack(target)
  end

  def roll_crit(dice)
    hit = parse_die(dice)
    damage = 0
    hit.each do |hit|
      hit_split =  hit.split(/[^\d]/)
      if hit_split[2] != nil
        damage = hit_split[2].to_i
      else
        damage = 0
      end
      (hit_split[0].to_i).times do
        damage += ((1..hit_split[1].to_i).to_a.sample * 2)
      end
    end
    damage
  end

  def roll_damage(dice)
    hit = parse_die(dice)
    damage = 0
    hit.each do |hit|
      hit_split =  hit.split(/[^\d]/)
      if hit_split[2] != nil
        damage = hit_split[2].to_i
      else
        damage = 0
      end
      (hit_split[0].to_i).times do
        damage += (1..hit_split[1].to_i).to_a.sample
      end
    end
    damage
  end

  def parse_die(dice)
    if dice.class == Array
      dice.map {|d| d[:damage_dice]}
    else
      return [dice]
    end
  end

  def roll_die
    (1..20).to_a.sample
  end
end