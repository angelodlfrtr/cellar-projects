class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.belongs_to :project, index: true
      t.string :description
      t.boolean :closed, default: false
      t.boolean :deleted, default: false

      t.datetime :start_date
      t.datetime :end_date

      t.belongs_to :user, index: true

      t.timestamps
    end

    add_reference :tasks, :assigned, references: :users, index: true
    add_foreign_key :tasks, :users, column: :assigned_id
  end
end
