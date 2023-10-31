class MonsterSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :url
end
