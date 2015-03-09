class AssetLocation < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(c,m){ m.owner }, recipient: ->(c,m){ m.user }
  
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :assets, :foreign_key => 'asset_location_id'
    
  validates :name,  presence: true,  length: { minimum: 2, maximum: 30 }
    
end
