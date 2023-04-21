class RemoveUserIdFromBoards < ActiveRecord::Migration[7.0]
  def change
    remove_column :boards, :user_id

  end
end
