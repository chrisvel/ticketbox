class ChangeOwnerIdWithUserId < ActiveRecord::Migration
  
  def up
    rename_table :assets_assetlocation, :asset_locations
    rename_table :assets_business, :asset_businesses
    rename_table :assets_ticket, :tickets
    rename_table :assets_ticketcategory, :ticket_categories
  end 
  
end
