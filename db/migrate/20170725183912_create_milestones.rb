class CreateMilestones < ActiveRecord::Migration[5.1]
  def change
    create_table :milestones do |t|
      t.string :name
      t.datetime :deadline

      t.belongs_to :project

      t.timestamps
    end
  end
end
