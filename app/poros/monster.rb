class Monster
  attr_reader :id, :name, :url, :index

  def initialize(info)
    @id = nil
    @index = info[:index]
    @name = info[:name]
    @url = info[:url]
  end
end