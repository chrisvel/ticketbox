class AddLeaverColumnToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :leaver, :boolean, null: false, default: false
  end
  
  def down 
    remove_column :users, :leaver
  end
  
end
