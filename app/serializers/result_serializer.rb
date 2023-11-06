class ResultSerializer
include JSONAPI::Serializer
attributes :id, :total_wins, :total_loses, :total_rounds, :win_percentage, :p1_stats, :p2_stats, :p3_stats, :p4_stats, :p5_stats
end