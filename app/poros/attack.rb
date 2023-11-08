class Attack
  attr_reader :name, :description, :action, :hit_bonus,
              :usage, :saving_throw, :damage_dice

  def initialize(data)
    @name = data[:name]
    @description = data[:desc] if data[:desc]
    @action = parse_multiattack(data)
    @hit_bonus = data[:attack_bonus]
    @usage = data[:usage] if data[:usage]
    @saving_throw = {
      type: data[:dc][:dc_type][:index], 
      threshold: data[:dc][:dc_value], 
      success: data[:dc][:success_type]
      } if data[:dc]
    @damage_dice = data[:damage] if data[:damage]
    breath_weapon(data) if data[:name] == "Breath Weapons"
  end

  def max_damage
    if @damage_dice
      @damage_dice.sum do |e|
        if e[:from]
          nums = e[:from][:options].last[:damage_dice].split(/[^\d]/)
        else
          nums = e[:damage_dice].split(/[^\d]/)
        end
        (nums[0].to_i * nums[1].to_i) + nums[2].to_i
      end
    else
      0
    end
  end

  def attack(target, creature)
    creature.attempt_hit
    if !@saving_throw
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
    else
      roll = (roll_die + target.saving_throw(@saving_throw[:type]))
      if roll >= @saving_throw[:threshold]
        if @saving_throw[:success] == "half"
          creature.damage_output(target.take_damage(roll_damage / 2))
        else
          target.missed_me
        end
      else
        creature.damage_output(target.take_damage(roll_damage))
      end
    end
  end

  def aoe(targets, creature)
    damage = roll_damage
    targets.each do |target|
      creature.attempt_hit
      roll = (roll_die + target.saving_throw(@saving_throw[:type]))
      if roll >= @saving_throw[:threshold]
        if @saving_throw[:success] == "half"
          creature.damage_output(target.take_damage(damage / 2))
        else
          target.missed_me
        end
      else
        creature.damage_output(target.take_damage(damage))
      end
    end
  end

  private

  def roll_crit
    hit = parse_die
    damage = 0
    hit.each do |hit|
      hit_split =  hit.split(/[^\d]/)
      if hit_split.count != 1
        if hit_split[2] != nil
          damage += hit_split[2].to_i
        else
          damage += 0
        end
        (hit_split[0].to_i).times do
          damage += ((1..hit_split[1].to_i).to_a.sample * 2)
        end
      else
        damage += hit_split[0].to_i
      end
    end
    damage
  end
  
  def roll_damage
    hit = parse_die
    damage = 0
    hit.each do |h|
      hit_split =  h.split(/[^\d]/)
      if hit_split.count != 1
        if hit_split[2] != nil
          damage += hit_split[2].to_i
        else
          damage += 0
        end
        (hit_split[0].to_i).times do
          damage += (1..hit_split[1].to_i).to_a.sample
        end
      else
        damage += hit_split[0].to_i
      end
    end
    damage
  end
  
  def parse_die
    if @damage_dice.class == Array
      @damage_dice.map do |d|
        if !d[:from]
          d[:damage_dice]
        else
          d[:from][:options][0][:damage_dice]
        end
      end
    else
      if !@damge_dice
        require 'pry'; binding.pry
      end
      return [@damage_dice[:damage_dice]]
    end
  end

  def parse_multiattack(data)
    if data[:actions] == [] || data[:actions] == nil
      if data[:action_options] == [] || data[:action_options] == nil
        action = nil
      elsif !data[:action_options][:from][:options][0][:items]
        action = [data[:action_options][:from][:options][0]]
      else
        action = data[:action_options][:from][:options][0][:items]
      end
    else
      action = data[:actions]
    end
    @action = action
  end

  def breath_weapon(data)
    info = data[:options][:from][:options][0]
    @name = info[:name]
    @saving_throw = {
      type: info[:dc][:dc_type][:index], 
      threshold: info[:dc][:dc_value], 
      success: info[:dc][:success_type]}
    @damage_dice = info[:damage]
  end
  
  def roll_die
    (1..20).to_a.sample
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
end