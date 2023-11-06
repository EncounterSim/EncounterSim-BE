class Result
  attr_reader :id, :total_wins, :total_loses, :total_rounds, :win_percentage

  def initialize(sim_id)
    @id = sim_id
    @total_rounds = 
    @total_wins = total_wins
    @total_loses = total_loses
    @win_percentage = win_percentage
  end

  def total_rounds
    Simulation.find(@id).combat_rounds.count
  end

  def total_wins
    Simulation.find(@id).combat_results.where(outcome: "Win").count
  end

  def total_loses
    Simulation.find(@id).combat_results.where(outcome: "Lose").count
  end
  
  def win_percentage
    (total_wins.to_f / total_rounds.to_f).round(2)
  end

  def damage_by_combat
    total_damage("p1").each_with_object({}) do |e, hash|
      hash[e.id] = e.total_damage
    end
  end

  def total_damage(creature)
    Simulation.find(@id)
    .combats
    .joins(:combat_rounds)
    .select("combats.*, sum(combat_rounds.#{creature}_damage_dealt) as total_damage")
    .group(:id)
    .order(:id)
  end
end