class AddRoleIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :role, null: false
  end
end
