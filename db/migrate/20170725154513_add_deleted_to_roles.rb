class AddDeletedToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :deleted, :boolean, default: false
  end
end
