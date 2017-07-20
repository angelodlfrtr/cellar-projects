class CreateInternalEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :internal_events do |t|
      t.string   :subject
      t.string   :data # JSON Stringyfied
      t.string   :klass
      t.integer  :subject_id

      t.belongs_to :project, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end

    add_index(:internal_events, :subject_id)
  end
end
