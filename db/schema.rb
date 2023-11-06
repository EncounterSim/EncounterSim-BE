# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_11_05_182908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "combat_results", force: :cascade do |t|
    t.bigint "combat_id", null: false
    t.integer "outcome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "p1_attacks_attempted"
    t.integer "p1_attacks_successful"
    t.integer "p1_attacks_against_me"
    t.integer "p1_attacks_hit_me"
    t.integer "p2_attacks_attempted"
    t.integer "p2_attacks_successful"
    t.integer "p2_attacks_against_me"
    t.integer "p2_attacks_hit_me"
    t.integer "p3_attacks_attempted"
    t.integer "p3_attacks_successful"
    t.integer "p3_attacks_against_me"
    t.integer "p3_attacks_hit_me"
    t.integer "p4_attacks_attempted"
    t.integer "p4_attacks_successful"
    t.integer "p4_attacks_against_me"
    t.integer "p4_attacks_hit_me"
    t.integer "p5_attacks_attempted"
    t.integer "p5_attacks_successful"
    t.integer "p5_attacks_against_me"
    t.integer "p5_attacks_hit_me"
    t.integer "monster_attacks_attempted"
    t.integer "monster_attacks_successful"
    t.integer "monster_attacks_against_me"
    t.integer "monster_attacks_hit_me"
    t.index ["combat_id"], name: "index_combat_results_on_combat_id"
  end

  create_table "combat_rounds", force: :cascade do |t|
    t.bigint "combat_id", null: false
    t.integer "p1_health"
    t.integer "p1_resources"
    t.integer "p1_damage_dealt"
    t.integer "p2_health"
    t.integer "p2_resources"
    t.integer "p2_damage_dealt"
    t.integer "p3_health"
    t.integer "p3_resources"
    t.integer "p3_damage_dealt"
    t.integer "p4_health"
    t.integer "p4_resources"
    t.integer "p4_damage_dealt"
    t.integer "p5_health"
    t.integer "p5_resources"
    t.integer "p5_damage_dealt"
    t.integer "monster_health"
    t.integer "monster_resources"
    t.integer "monster_damage_dealt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["combat_id"], name: "index_combat_rounds_on_combat_id"
  end

  create_table "combats", force: :cascade do |t|
    t.bigint "simulation_id", null: false
    t.string "p1"
    t.string "p2"
    t.string "p3"
    t.string "p4"
    t.string "p5"
    t.string "monster"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "p1_initiative"
    t.integer "p2_initiative"
    t.integer "p3_initiative"
    t.integer "p4_initiative"
    t.integer "p5_initiative"
    t.integer "monster_initiative"
    t.index ["simulation_id"], name: "index_combats_on_simulation_id"
  end

  create_table "simulations", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "combat_results", "combats"
  add_foreign_key "combat_rounds", "combats"
  add_foreign_key "combats", "simulations"
end
