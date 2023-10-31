class Monster
  attr_reader :id, :name, :url

  def initialize(info)
    @id = nil
    @name = info[:name]
    @url = info[:url]
  end
end