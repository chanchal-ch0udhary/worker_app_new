class DropselectedUsers < ActiveRecord::Migration[7.1]
  def change
    drop_table :selected_users
  end
end
