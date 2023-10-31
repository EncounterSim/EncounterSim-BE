class Api::V1::MonstersController < ApplicationController

  def index
    render json: MonsterSerializer.new(DndFacade.new.monsters)
  end
end