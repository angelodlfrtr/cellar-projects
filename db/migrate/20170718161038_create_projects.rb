class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.date :deadline

      t.timestamps
    end
  end
end
