class ResultSerializer
include JSONAPI::Serializer
attributes :id, :total_combats, :total_rounds, :total_wins, :total_loses, 
           :win_percentage, :damage_per_combat, :p1_stats, :p2_stats,
           :p3_stats, :p4_stats, :p5_stats, :monster_stats
end