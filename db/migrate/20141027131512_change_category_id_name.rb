class ChangeCategoryIdName < ActiveRecord::Migration
  
  def up
    rename_column :tickets, :category_id, :ticket_category_id
    rename_column :ticket_categories, :category, :name
    rename_column :asset_locations, :location, :name
  end
  
  def down
    rename_column :tickets, :ticket_category_id, :category_id
    rename_column :ticket_categories, :name, :category
    rename_column :asset_locations, :name, :location
  end
  
end
