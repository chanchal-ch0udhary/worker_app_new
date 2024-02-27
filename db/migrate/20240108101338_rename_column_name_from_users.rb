class RenameColumnNameFromUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :Bio, :bio
  end
end
