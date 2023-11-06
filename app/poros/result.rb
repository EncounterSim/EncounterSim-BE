class Result
  attr_reader :id, :total_wins, :total_loses, :total_rounds, 
              :win_percentage, :p1_stats, :p2_stats, :p3_stats,
              :p4_stats, :p5_stats

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
    (total_wins.to_f / total_rounds.to_f).round(2)
  end

  def per_combat_hash
    this = {
      p1: damage_by_combat("p1"),
      p2: damage_by_combat("p2"),
      p3: damage_by_combat("p3"),
      p4: damage_by_combat("p4"),
      p5: damage_by_combat("p5"),
      monster: damage_by_combat("monster")
    }
    require 'pry'; binding.pry
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

  def hit_rate(p)
    @sim
    .combat_results
    .average("#{p}_attacks_successful::float / #{p}_attacks_attempted::float")
  end

  def avg_damage_per_round(p)
    (@sim.combat_rounds.sum("#{p}_damage_dealt").to_f / @sim.combat_rounds.count.to_f).round(2)
  end

  def stats(p)
    {
      player: p,
      avg_dmg: avg_damage_per_round(p)
    }
  end
end