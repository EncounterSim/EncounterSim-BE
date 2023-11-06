class SimulationSerializer
  include JSONAPI::Serializer
  attributes :id, :user_id
end
