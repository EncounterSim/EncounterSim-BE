class DndService 

  def conn
    Faraday.new(url: "https://www.dnd5eapi.co/api/")
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def monsters
    get_url("monsters")
  end
  
  def spells
    get_url("spells")
  end
  
  def players
    get_url("classes")
  end
end