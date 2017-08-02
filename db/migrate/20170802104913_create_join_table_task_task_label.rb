class CreateJoinTableTaskTaskLabel < ActiveRecord::Migration[5.1]
  def change
    create_join_table :tasks, :task_labels do |t|
      t.index [:task_id, :task_label_id]
      t.index [:task_label_id, :task_id]
    end
  end
end
