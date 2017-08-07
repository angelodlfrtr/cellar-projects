class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|

      t.belongs_to :project
      t.belongs_to :user
      t.string :metadata
      t.string :name

      t.timestamps
    end
  end
end
