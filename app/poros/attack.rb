class Attack
  attr_reader :name, :action

  def initialize(data)
    @name = data[:name]
    @description = data[:desc] if data[:desc]
    @action = data[:actions] if data[:actions]
    @hit_bonus = data[:attack_bonus]
    @usage = data[:usage] if data[:usage]
    @saving_throw = {
      type: data[:dc][:dc_type][:name], 
      threshold: data[:dc][:dc_value], 
      success: data[:dc][:success_type]
    } if data[:dc]
    @damage_dice = data[:damage] if data[:damage]
  end

  def max_damage
    if @damage_dice
      @damage_dice.sum do |k, v|
        nums = v.split(/[^\d]/)
        (nums[0].to_i * nums[1].to_i) + nums[2].to_i
      end
    else
      0
    end
  end

  def attack(target, creature)
    creature.attempt_hit
    roll = to_hit
    if roll == "Critical Miss"
      target.missed_me
    elsif roll == "Critical Hit"
      creature.damage_output(target.take_damage(roll_crit))
    elsif roll < target.armor_class
      target.missed_me
    else
      creature.damage_output(target.take_damage(roll_damage))
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

  def roll_crit
    hit = parse_die
    damage = 0
    hit.each do |hit|
      hit_split =  hit.split(/[^\d]/)
      if hit_split[2] != nil
        damage += hit_split[2].to_i
      else
        damage += 0
      end
      (hit_split[0].to_i).times do
        damage += ((1..hit_split[1].to_i).to_a.sample * 2)
      end
    end
    damage
  end

  def roll_damage
    hit = parse_die
    damage = 0
    hit.each do |h|
      hit_split =  h.split(/[^\d]/)
      if hit_split[2] != nil
        damage += hit_split[2].to_i
      else
        damage += 0
      end
      (hit_split[0].to_i).times do
        damage += (1..hit_split[1].to_i).to_a.sample
      end
    end
    damage
  end

  def parse_die
    if @damage_dice.class == Array
      @damage_dice.map {|d| d[:damage_dice]}
    else
      return [@damage_dice[:damage_dice]]
    end
  end

  def roll_die
    (1..20).to_a.sample
  end
end