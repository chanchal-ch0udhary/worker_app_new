class ChangeColumnInPosts < ActiveRecord::Migration[7.1]
  def change
    rename_column :posts, :role, :name
  end  
end
