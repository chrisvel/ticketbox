class AddAssetLocationIdToAssets < ActiveRecord::Migration
  
  def up
    rename_column :assets, :location_id, :asset_location_id
  end
  
  def down
    rename_column :assets, :asset_location_id, :location_id
  end
  
end
