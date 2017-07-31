class AddMilestoneToTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :deadline
    add_reference :tasks, :milestone, index: true
  end
end
