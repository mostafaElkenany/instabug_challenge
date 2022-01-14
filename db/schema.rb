ActiveRecord::Schema.define(version: 2022_01_14_200622) do

  create_table "applications", charset: "utf8mb4", force: :cascade do |t|
    t.string "token"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["token"], name: "index_applications_on_token", unique: true
  end

end
