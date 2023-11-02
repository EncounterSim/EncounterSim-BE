class Sim

  def initialize
    @round = 0
    @pcs = []
    @enemies = []
    @initiative = [].sort_by {|k| k[:initiative]}.reverse
  end

  def take_turn(creature)
    action = creature.determine_action
    target = determine_target(creature)
    if target
      action.each do |each|
        (each[:count].to_i).times do
          if target.hit_points > 0
            each[:attack].attack(target)
          else
            target = determine_target(creature)
            each[:attack].attack(target)
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
      # save_round
      round
    else
      end_combat
    end
  end

  def roll_die
    (1..20).to_a.sample
  end

  def save_round
    results = {
      pc_healths: @pcs.map {|pc| pc.hit_points},
      enemy_health: @enemies.map {|e| e.hit_points}
    }
    p results
  end

  def end_combat
    results = {
      pc_healths: @pcs.map {|pc| pc.hit_points},
      enemy_health: @enemies.map {|e| e.hit_points}
    }
    p results
  end
end