class RemoveStartColumnInTasks < ActiveRecord::Migration[5.1]
  def change
    remove_column :tasks, :start_date
    rename_column :tasks, :end_date, :deadline
  end
end
