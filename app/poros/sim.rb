class Sim

  def initialize(sim_id)
    @simulation = sim_id
    @combat = nil
    @pcs = []
    @enemies = []
    @initiative = [].sort_by {|k| k[:initiative]}.reverse
  end

  def start_combat
    @combat = Simulation.find(@simulation).combats.create!
    round = @combat.combat_rounds.create!
    @pcs.each_with_index do |pc, num|
      @combat.update!("p#{num + 1}" => pc.name)
      round.update!("p#{num + 1}_health" => pc.hit_points,
                    "p#{num + 1}_resources" => pc.resources,
                    "p#{num + 1}_damage_dealt" => 0)
    end

    @enemies.each_with_index do |e, num|
      @combat.update!(monster: e.name)
      round.update!(monster_health: e.hit_points,
                    monster_resources: 0,
                    monster_damage_dealt: 0)
    end
  end

  def take_turn(creature)
    creature.reset_damage_dealt
    action = creature.determine_action
    target = determine_target(creature)
    if target
      action.each do |each|
        (each[:count].to_i).times do
          if target
            if target.hit_points > 0
              each[:attack].attack(target, creature)
            else
              target = determine_target(creature)
              if target
                each[:attack].attack(target, creature)
              end
            end
          end
        end
      end
    end
  end

  def determine_target(creature)
    if @pcs.any? {|pc| pc.name == creature.name}
      @enemies.select {|e| e.hit_points > 0}.sample
    else
      @pcs.select {|p| p.hit_points >0}.sample
    end
  end

  def roll_initiative(pcs, enemies)
    pcs.each do |pc|
      @pcs << pc
      @initiative << {name: pc.name, initiative: roll_die + pc.dexterity}
    end
    enemies.each do |enemy|
      @enemies << enemy
      @initiative << {name: enemy.name, initiative: roll_die + enemy.dexterity}
    end
    start_combat
    round
  end

  def determine_combatant(name)
    pc = @pcs.select {|pc| pc.name == name[:name]}
    if pc == []
      @enemies.select {|enemy| enemy.name == name[:name]}[0]
    else
      pc[0]
    end
  end

  def round
    @initiative.each do |name|
      creature = determine_combatant(name)
      if creature && creature.hit_points > 0
        take_turn(creature)
      end
    end
    determine_end_of_combat
  end
  
  def determine_end_of_combat
    @pcs = @pcs.select {|p| p.hit_points > 0}
    @enemies = @enemies.select {|e| e.hit_points > 0}
    if @pcs.count > 0 && @enemies.count > 0
      save_round
      round
    elsif @pcs.count > 0
      save_round
      end_combat("Win")
    else
      save_round
      end_combat("Lose")
    end
  end

  def roll_die
    (1..20).to_a.sample
  end

  def save_round
    round = @combat.combat_rounds.create!
    @pcs.each_with_index do |pc, num|
      round.update!("p#{num + 1}_health" => pc.hit_points,
                    "p#{num + 1}_resources" => pc.resources,
                    "p#{num + 1}_damage_dealt" => pc.damage_dealt)
    end

    @enemies.each_with_index do |e, num|
      round.update!(monster_health: e.hit_points,
                    monster_resources: 0,
                    monster_damage_dealt: e.damage_dealt)
    end
  end

  def end_combat(result)
    @combat.combat_results.create!(outcome: result)
  end
end