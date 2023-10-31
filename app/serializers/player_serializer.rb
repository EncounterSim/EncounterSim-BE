class PlayerSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :url
end
