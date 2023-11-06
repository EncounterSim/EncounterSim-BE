class Result
  attr_reader :id, :total_combats, :total_rounds, :total_wins, :total_loses, 
              :win_percentage, :damage_per_combat, :p1_stats, :p2_stats,
              :p3_stats, :p4_stats, :p5_stats, :monster_stats

  def initialize(sim_id)
    @id = sim_id
    @sim = Simulation.find(@id)
    @total_combats = total_combats
    @total_rounds = total_rounds
    @total_wins = total_wins
    @total_loses = total_loses
    @win_percentage = win_percentage
    @damage_per_combat = per_combat_hash
    @p1_stats = stats("p1")
    @p2_stats = stats("p2")
    @p3_stats = stats("p3")
    @p4_stats = stats("p4")
    @p5_stats = stats("p5")
    @monster_stats = stats("monster")
  end

  def active_combatant(p)
    @sim.combats.where("#{p}": nil).count == 0
  end

  def total_combats
    @sim.combats.count
  end

  def total_rounds
    @sim.combat_rounds.count
  end

  def total_wins
    @sim.combat_results.where(outcome: "Win").count
  end

  def total_loses
    @sim.combat_results.where(outcome: "Lose").count
  end
  
  def win_percentage
      (total_wins.to_f / total_combats.to_f).round(2)
  end

  def per_combat_hash
    {
      p1: {total_damage: damage_by_combat("p1"), hit_rate: hit_rate_per_combat("p1")},
      p2: {total_damage: damage_by_combat("p2"), hit_rate: hit_rate_per_combat("p2")},
      p3: {total_damage: damage_by_combat("p3"), hit_rate: hit_rate_per_combat("p3")},
      p4: {total_damage: damage_by_combat("p4"), hit_rate: hit_rate_per_combat("p4")},
      p5: {total_damage: damage_by_combat("p5"), hit_rate: hit_rate_per_combat("p5")},
      monster: {total_damage: damage_by_combat("monster"), hit_rate: hit_rate_per_combat("monster")}
    }
  end

  def damage_by_combat(creature)
    total_damage(creature).each_with_object({}) do |e, hash|
      hash[e.id] = e.total_damage
    end
  end

  def total_damage(creature)
    @sim
    .combats
    .joins(:combat_rounds)
    .select("combats.*, sum(combat_rounds.#{creature}_damage_dealt) as total_damage")
    .group(:id)
    .order(:id)
  end

  def hit_rate_per_combat(p)
    if active_combatant(p)
      total_attacks = attacks_made_per_combat(p)
      successful_attacks_per_combat(p).map.with_index do |each, index|
        {"#{each.id}": (each.successful_attacks.to_f / total_attacks[index].attacks_made.to_f).round(2)}
      end
    else
      nil
    end
  end

  def total_hit_rate(p)
    if active_combatant(p)
      total_attacks = attacks_made_per_combat(p).sum {|each| each.attacks_made}
      successful_attacks = successful_attacks_per_combat(p).sum {|each| each.successful_attacks}
      (successful_attacks.to_f / total_attacks.to_f).round(2)
    else
      nil
    end
  end

  def successful_attacks_per_combat(p)
    if active_combatant(p)
      @sim
      .combats
      .joins(:combat_results)
      .select("combats.*, sum(combat_results.#{p}_attacks_successful) as successful_attacks")
      .group(:id)
      .order(:id)
      # .average("#{p}_attacks_successful::float / #{p}_attacks_attempted::float").round(2)
    else
      nil
    end
  end
  
  def attacks_made_per_combat(p)
    if active_combatant(p)
      @sim
      .combats
      .joins(:combat_results)
      .select("combats.*, sum(combat_results.#{p}_attacks_attempted) as attacks_made")
      .group(:id)
      .order(:id)
      # .average("#{p}_attacks_successful::float / #{p}_attacks_attempted::float").round(2)
    else
      nil
    end
  end

  def avg_damage_per_round(p)
    if active_combatant(p)
      (@sim.combat_rounds.sum("#{p}_damage_dealt").to_f / @sim.combat_rounds.count.to_f).round(2)
    else
      nil
    end
  end

  def stats(p)
    if active_combatant(p)
      {
        player: p,
        avg_dmg: avg_damage_per_round(p),
        hit_rate: total_hit_rate(p)
      }
    else
      nil
    end
  end
end