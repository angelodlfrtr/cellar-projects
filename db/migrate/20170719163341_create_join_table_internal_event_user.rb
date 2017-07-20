class CreateJoinTableInternalEventUser < ActiveRecord::Migration[5.1]
  def change
    create_join_table :internal_events, :users do |t|
      t.index [:internal_event_id, :user_id], unique: true
      t.index [:user_id, :internal_event_id], unique: true
    end
  end
end
