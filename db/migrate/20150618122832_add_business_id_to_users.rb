class AddBusinessIdToUsers < ActiveRecord::Migration
  
  def up
    add_column :users, :business_id, :integer
    add_foreign_key :users, :businesses, index: true
  end
  
  def down 
    remove_foreign_key :users, :businesses
    remove_column :users, :business_id
  end
  
end
