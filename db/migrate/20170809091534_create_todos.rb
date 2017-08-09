class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string    :title
      t.text      :content
      t.datetime  :deadline
      t.boolean   :done, default: false
      t.datetime  :done_at

      t.belongs_to :user
      t.timestamps
    end
  end
end
