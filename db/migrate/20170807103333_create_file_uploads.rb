class CreateFileUploads < ActiveRecord::Migration[5.1]
  def change
    create_table :file_uploads do |t|
      t.string :file
      t.string :metadata

      t.string :klass
      t.integer :klass_id

      t.timestamps
    end

    add_index(:file_uploads, :klass_id)
  end
end
