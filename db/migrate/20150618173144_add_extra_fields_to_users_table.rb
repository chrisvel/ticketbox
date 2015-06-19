class AddExtraFieldsToUsersTable < ActiveRecord::Migration
  
  def up
    add_column :users, :department, :string
    add_column :users, :position, :string
    add_column :users, :landline_phone, :string
    add_column :users, :mobile_phone, :string
  end
  
  def down 
    remove_column :users, :mobile_phone
    remove_column :users, :landline_phone
    remove_column :users, :position
    remove_column :users, :department    
  end
  
end
