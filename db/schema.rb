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

ActiveRecord::Schema.define(version: 2022_03_05_222341) do

  create_table "ads", force: :cascade do |t|
    t.integer "user_id"
    t.string "contact_person"
    t.string "email"
    t.string "phonenumber"
    t.string "title"
    t.string "category"
    t.text "description"
    t.string "prix"
    t.string "localite"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "publish"
    t.string "url"
    t.integer "vues"
    t.date "expires"
    t.boolean "verified"
  end

  create_table "albums", force: :cascade do |t|
    t.integer "phototheque_id"
    t.integer "user_id"
    t.string "title"
    t.integer "vues"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "artcats", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "cat_parent_id"
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.text "content"
    t.string "auteur"
    t.date "date"
    t.integer "vues"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.string "type"
    t.integer "artcat_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "email"
    t.integer "quantite"
    t.string "mobile"
    t.boolean "bill"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "country_code"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.integer "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "performer"
    t.text "description"
    t.date "startDate"
    t.date "endDate"
    t.string "date"
    t.string "image"
    t.integer "price"
    t.string "priceCurrency"
    t.integer "place_id"
    t.time "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.time "length"
  end

  create_table "messages", force: :cascade do |t|
    t.string "your_name"
    t.string "your_email"
    t.string "your_subject"
    t.string "your_message"
  end

  create_table "photos", force: :cascade do |t|
    t.integer "album_id"
    t.string "title"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "phototheques", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "places", force: :cascade do |t|
    t.string "type"
    t.string "name"
    t.string "image"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "zip"
    t.integer "city_id"
    t.integer "country_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "event_id"
    t.integer "buyer_id"
    t.integer "quantite"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "clientcode"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "staff"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.string "image"
  end

end
