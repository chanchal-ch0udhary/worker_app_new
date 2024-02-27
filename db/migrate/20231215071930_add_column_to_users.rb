class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :role, :string
    add_column :users, :name, :string
    add_column :users, :phone_no, :integer
    add_column :users, :address, :text
    add_column :users, :Bio, :text
  end
end
