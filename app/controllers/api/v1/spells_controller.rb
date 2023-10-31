class Api::V1::SpellsController < ApplicationController

  def index
    render json: SpellSerializer.new(DndFacade.new.spells)
  end

end