class SimSpell
  attr_reader :index, :duration, :casting_time, :level,
              :damage, :saving_throw, :aoe

  def initialize(data)
    @index = data[:index]
    @duration = data[:duration]
    @casting_time = data[:casting_time]
    @level = data[:level]
    @damage = data[:damage][:damage_at_slot_level] if data[:damage]
    @saving_throw = {
      type: data[:dc][:dc_type][:index], 
      dc_success: data[:dc][:dc_success]
    } if data[:dc]
    @aoe = data[:area_of_effect] if data[:area_of_effect]
  end

  def max_damage(spell_level)
    if can_cast(spell_level) && @damage
      if @damage[:"#{spell_level}"]
        dice = @damage[:"#{spell_level}"].split(/[^\d]/)
        (dice[0].to_i * dice[1].to_i) + dice[2].to_i
      else
        dice = @damage.first[1].split(/[^\d]/)
        (dice[0].to_i * dice[1].to_i) + dice[2].to_i
      end
    else
      0
    end
  end

  def attack(target, creature)
    creature.attempt_hit
    level_cast = creature.cast_level
    if !@saving_throw
      roll = to_hit(creature.spell_to_hit)
      if roll == "Critical Miss"
        target.missed_me
      elsif roll == "Critical Hit"
        if creature.name == "Paladin"
          creature.damage_output(target.take_damage(roll_crit(level_cast)), "crit")
        else
          creature.damage_output(target.take_damage(roll_crit(level_cast)))
        end
      elsif roll < target.armor_class
        target.missed_me
      else
        if creature.name == "Paladin"
          creature.damage_output(target.take_damage(roll_damage(level_cast)), "norm")
        else
          creature.damage_output(target.take_damage(roll_damage(level_cast)))
        end
      end
    else
      roll = (roll_die + target.saving_throw(@saving_throw[:type]))
      if roll >= creature.spell_save_dc
        if @saving_throw[:dc_success] == "half"
          if creature.name == "Paladin"
            creature.damage_output(target.take_damage(roll_damage(level_cast) / 2), "half")
          else
            creature.damage_output(target.take_damage(roll_damage(level_cast) / 2))
          end
        else
          target.missed_me
        end
      else
        if creature.name == "Paladin"
          creature.damage_output(target.take_damage(roll_damage(level_cast)), "norm")
        else
          creature.damage_output(target.take_damage(roll_damage(level_cast)))
        end
      end
    end
  end

  def to_hit(hit_bonus)
    roll = roll_die
    if roll == 20
      "Critical Hit"
    elsif roll == 1
      "Critical Miss"
    else
      roll + hit_bonus
    end
  end

  def roll_crit(level_cast)
    hit = @damage[:"#{level_cast}"]
    damage = 0
    hit_split = hit.split(/[^\d]/)
    if hit_split[2] != nil
      damage += hit_split[2].to_i
    end
    (hit_split[0].to_i).times do
      damage += ((1..hit_split[1].to_i).to_a.sample * 2)
    end
    damage
  end

  def roll_damage(level_cast)
    hit = @damage[:"#{level_cast}"]
    damage = 0
    hit_split =  hit.split(/[^\d]/)
    if hit_split[2] != nil
      damage += hit_split[2].to_i
    end
    (hit_split[0].to_i).times do
      damage += (1..hit_split[1].to_i).to_a.sample
    end
    damage
  end

  def roll_die
    (1..20).to_a.sample
  end

  def can_cast(spell_level)
    @level <= spell_level.to_i
  end
end