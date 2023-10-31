class DndFacade
  
  def initialize()
    @service = DndService.new
  end

  def monsters
    @service.monsters
    
  end
end