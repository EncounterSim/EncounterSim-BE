class ResultSerializer
include JSONAPI::Serializer
attributes :id, :total_wins, :total_loses, :total_rounds, :win_percentage
end