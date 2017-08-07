# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170807121642) do

  create_table "document_labels", force: :cascade do |t|
    t.string "name"
    t.string "color_code"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_document_labels_on_project_id"
  end

  create_table "document_labels_documents", id: false, force: :cascade do |t|
    t.integer "document_label_id", null: false
    t.integer "document_id", null: false
    t.index ["document_id", "document_label_id"], name: "index_doc_labels_docs_on_doc_id_and_doc_label_id"
    t.index ["document_label_id", "document_id"], name: "index_doc_labels_docts_on_doc_label_id_and_doc_id"
  end

  create_table "documents", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.string "metadata"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_documents_on_project_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "file_uploads", force: :cascade do |t|
    t.string "file"
    t.string "metadata"
    t.string "klass"
    t.integer "klass_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_file_uploads_on_klass_id"
  end

  create_table "internal_events", force: :cascade do |t|
    t.string "subject"
    t.string "data"
    t.string "klass"
    t.integer "subject_id"
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_internal_events_on_project_id"
    t.index ["subject_id"], name: "index_internal_events_on_subject_id"
    t.index ["user_id"], name: "index_internal_events_on_user_id"
  end

  create_table "internal_events_users", id: false, force: :cascade do |t|
    t.integer "internal_event_id", null: false
    t.integer "user_id", null: false
    t.index ["internal_event_id", "user_id"], name: "index_internal_events_users_on_internal_event_id_and_user_id", unique: true
    t.index ["user_id", "internal_event_id"], name: "index_internal_events_users_on_user_id_and_internal_event_id", unique: true
  end

  create_table "milestones", force: :cascade do |t|
    t.string "name"
    t.datetime "deadline"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.text "description"
    t.date "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer "level"
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "deleted", default: false
    t.index ["project_id"], name: "index_roles_on_project_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "task_comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_task_comments_on_task_id"
    t.index ["user_id"], name: "index_task_comments_on_user_id"
  end

  create_table "task_labels", force: :cascade do |t|
    t.string "name"
    t.string "color_code"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_task_labels_on_project_id"
  end

  create_table "task_labels_tasks", id: false, force: :cascade do |t|
    t.integer "task_id", null: false
    t.integer "task_label_id", null: false
    t.index ["task_id", "task_label_id"], name: "index_task_labels_tasks_on_task_id_and_task_label_id"
    t.index ["task_label_id", "task_id"], name: "index_task_labels_tasks_on_task_label_id_and_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.integer "project_id"
    t.string "description"
    t.boolean "closed", default: false
    t.boolean "deleted", default: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "assigned_id"
    t.integer "milestone_id"
    t.index ["assigned_id"], name: "index_tasks_on_assigned_id"
    t.index ["milestone_id"], name: "index_tasks_on_milestone_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
