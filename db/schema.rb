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

ActiveRecord::Schema.define(version: 2021_01_17_172053) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "discounts", force: :cascade do |t|
    t.string "name"
    t.float "percentage"
    t.integer "minimum_quantity"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_discounts_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "price"
    t.string "url"
    t.integer "inventory"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "order_images", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "image_id", null: false
    t.float "price"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["image_id"], name: "index_order_images_on_image_id"
    t.index ["order_id"], name: "index_order_images_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "billing_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.bigint "cc_number"
    t.string "cc_name"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "email"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "discounts", "users"
  add_foreign_key "images", "users"
  add_foreign_key "order_images", "images"
  add_foreign_key "order_images", "orders"
  add_foreign_key "orders", "users"
end
