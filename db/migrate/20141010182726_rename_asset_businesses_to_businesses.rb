class RenameAssetBusinessesToBusinesses < ActiveRecord::Migration
  
  def up
    rename_table :asset_businesses, :businesses
  end 
  
end
