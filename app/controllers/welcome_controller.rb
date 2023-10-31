class WelcomeController < ApplicationController

  def index
    @monsters = DndFacade.new.monsters
    require 'pry';binding.pry
  end
end