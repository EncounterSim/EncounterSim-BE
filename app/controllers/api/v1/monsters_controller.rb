class Api::V1::MonstersController < ApplicationController

  def index
    render json: MonsterSerializer.new(DndFacade.new.monsters)
  end
  
  def show
    render json: SimMonsterSerializer.new(DndFacade.new.monster(params[:id]))
  end
end