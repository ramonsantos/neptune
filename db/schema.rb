# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_21_190553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accept_tests", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_story_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_story_id"], name: "index_accept_tests_on_user_story_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "releases", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "finish_date"
    t.boolean "active"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_releases_on_project_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_story_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_story_id"], name: "index_tasks_on_user_story_id"
  end

  create_table "user_stories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "release_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "situation", default: "To Do"
    t.index ["release_id"], name: "index_user_stories_on_release_id"
  end

  add_foreign_key "accept_tests", "user_stories"
  add_foreign_key "releases", "projects"
  add_foreign_key "tasks", "user_stories"
  add_foreign_key "user_stories", "releases"
end
