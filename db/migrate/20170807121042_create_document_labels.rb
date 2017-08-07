class CreateDocumentLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :document_labels do |t|
      t.string :name
      t.string :color_code

      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
