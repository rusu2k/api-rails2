class CreateInitialSchema < ActiveRecord::Migration[7.0]
  def change
    create_table "boards", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "title"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "user_id", default: 7
      t.index ["user_id"], name: "index_boards_on_user_id"
    end

    create_table "columns", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "title"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "board_id", null: false
      t.integer "position"
      t.index ["board_id"], name: "index_columns_on_board_id"
    end

    create_table "stories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
      t.string "title"
      t.string "content"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "column_id", null: false
      t.integer "status"
      t.date "due_date"
      t.index ["column_id"], name: "index_stories_on_column_id"
    end 

    add_foreign_key "columns", "boards"
    add_foreign_key "stories", "columns"
  end
end