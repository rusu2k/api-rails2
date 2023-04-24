class AddUserRefToBoards < ActiveRecord::Migration[7.0]
  def change
    add_reference :boards, :user, index: true
  end
end
