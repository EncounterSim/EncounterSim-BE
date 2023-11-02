class DndService 

  def conn
    Faraday.new(url: "https://www.dnd5eapi.co")
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def monsters
    get_url("/api/monsters")
  end
  
  def spells
    get_url("/api/spells")
  end
  
  def players
    get_url("/api/classes")
  end

  def monster(index)
    get_url("/api/monsters/#{index}")
  end

  def spell(index)
    get_url("/api/spells/#{index}")
  end
end