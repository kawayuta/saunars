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

ActiveRecord::Schema.define(version: 2021_03_23_173533) do

  create_table "sauna_amenities", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "sauna_id"
    t.boolean "shampoo", default: false
    t.boolean "conditioner", default: false
    t.boolean "body_soap", default: false
    t.boolean "face_soap", default: false
    t.boolean "razor", default: false
    t.boolean "toothbrush", default: false
    t.boolean "nylon_towel", default: false
    t.boolean "hairdryer", default: false
    t.boolean "face_towel_unlimited", default: false
    t.boolean "bath_towel_unlimited", default: false
    t.boolean "sauna_underpants_unlimited", default: false
    t.boolean "sauna_mat_unlimited", default: false
    t.boolean "flutterboard_unlimited", default: false
    t.boolean "toner", default: false
    t.boolean "emulsion", default: false
    t.boolean "makeup_remover", default: false
    t.boolean "cotton_swab", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sauna_id"], name: "index_sauna_amenities_on_sauna_id"
  end

  create_table "sauna_roles", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "sauna_id"
    t.boolean "loyly", default: false
    t.boolean "auto_loyly", default: false
    t.boolean "self_loyly", default: false
    t.boolean "gaikiyoku", default: false
    t.boolean "rest_space", default: false
    t.boolean "free_time", default: false
    t.boolean "capsule_hotel", default: false
    t.boolean "in_rest_space", default: false
    t.boolean "eat_space", default: false
    t.boolean "wifi", default: false
    t.boolean "power_source", default: false
    t.boolean "work_space", default: false
    t.boolean "manga", default: false
    t.boolean "body_care", default: false
    t.boolean "body_towel", default: false
    t.boolean "water_dispenser", default: false
    t.boolean "washlet", default: false
    t.boolean "credit_settlement", default: false
    t.boolean "parking_area", default: false
    t.boolean "ganbanyoku", default: false
    t.boolean "tattoo", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sauna_id"], name: "index_sauna_roles_on_sauna_id"
  end

  create_table "sauna_rooms", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "sauna_id"
    t.integer "sauna_temperature"
    t.integer "mizu_temperature"
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sauna_id"], name: "index_sauna_rooms_on_sauna_id"
  end

  create_table "sauna_tags", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "sauna_id"
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sauna_id"], name: "index_sauna_tags_on_sauna_id"
  end

  create_table "saunas", charset: "utf8mb4", force: :cascade do |t|
    t.string "name_ja"
    t.string "name_en"
    t.text "description"
    t.text "address"
    t.integer "gender"
    t.string "thumbnail"
    t.string "image"
    t.integer "price"
    t.text "holiday"
    t.text "tel", size: :long
    t.text "parking"
    t.text "hp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "username", null: false
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "wents", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "sauna_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sauna_id"], name: "index_wents_on_sauna_id"
    t.index ["user_id"], name: "index_wents_on_user_id"
  end

  add_foreign_key "sauna_amenities", "saunas"
  add_foreign_key "sauna_roles", "saunas"
  add_foreign_key "sauna_rooms", "saunas"
  add_foreign_key "sauna_tags", "saunas"
  add_foreign_key "wents", "saunas"
  add_foreign_key "wents", "users"
end
