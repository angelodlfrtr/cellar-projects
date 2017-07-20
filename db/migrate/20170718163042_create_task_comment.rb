class CreateTaskComment < ActiveRecord::Migration[5.1]
  def change
    create_table :task_comments do |t|
      t.text :content
      t.belongs_to :user, index: true
      t.belongs_to :task, index: true

      t.timestamps
    end
  end
end
