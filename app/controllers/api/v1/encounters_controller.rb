class Api::V1::EncountersController < ApplicationController

  def index
    render json: SimulationSerializer.new(Simulation.where(user_id: params[:user_id]))
  end

  def create
    data = JSON.parse(request.body.read, symbolize_names: true)
    players = parse_players(params[:characters])
    monster_name = index_name(params[:monster])
    new_sim = Simulation.create!(user_id: params[:user_id])
    (15).times do
      pcs = players.map {|player| PlayerCharacter.make_character(player)}
      monster ||= DndFacade.new.monster(monster_name)
      sim_runner = Sim.new(new_sim.id)
      sim_runner.roll_initiative(pcs, [monster])
    end
    render json: ResultSerializer.new(Result.new(new_sim.id))
    # Pry here to check simulation data
    # Simulation.last.combats.last.combat_results
    # Simulation.last.combats.last.combat_rounds
  end

  def show
    sim = Simulation.find(params[:id])
    render json: ResultSerializer.new(Result.new(sim.id))
  end

  private

  def index_name(name)
    name.downcase.gsub(" ", "-")
  end

  def parse_players(players_hash)
    active_players = players_hash.select {|p| p[:hit_points] != ""}
    active_players.map.with_index do |player, index|
      player_hash = player_permit(player).to_h
      level_info = DndFacade.new.player(player_hash[:class].downcase)
      player_hash[:id] = index
      player_hash[:damage_die] = "#{player_hash[:damage_die1]}"+"#{player_hash[:damage_die2]}"
      player_hash[:prof_bonus] = level_info[player_hash[:level].to_i - 1][:prof_bonus]
      player_hash[:spells] = [DndFacade.new.spell(index_name(player_hash[:spell1])), DndFacade.new.spell(index_name(player_hash[:spell2])), DndFacade.new.spell(index_name(player_hash[:spell3]))]
      if level_info[0][:spellcasting]
        player_hash[:spellcasting] = level_info[player_hash[:level].to_i - 1][:spellcasting]
      end
      player_hash[:class_specific] = level_info[player_hash[:level].to_i - 1][:class_specific]
      player_hash[:features] = []
      index = 0
      while index <= (player_hash[:level].to_i - 1)
        feat_names = level_info[index][:features].map { |each| each[:name] }
        player_hash[:features].concat(feat_names)
        index += 1
      end
      player_hash
    end
  end

  def player_permit(player)
    player.permit(:class, :level, :strength, :dexterity, :constitution, :wisdom, :charisma, :intelligence, :spell1, :spell2, :spell3, :hit_points, :armor_class, :damage_die1, :damage_die2)
  end
end