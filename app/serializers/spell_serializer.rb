class SpellSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :url
end
