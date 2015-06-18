class AssetLocation < ActiveRecord::Base
  include PublicActivity::Model
  tracked user: ->(c,m){ m.user }, recipient: ->(c,m){ m.user }
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :assets, :foreign_key => 'asset_location_id'
    
  validates :name,  presence: true,  length: { minimum: 2, maximum: 30 }
    
end
