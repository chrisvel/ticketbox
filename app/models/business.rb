class Business < ActiveRecord::Base
  include PublicActivity::Model
  #tracked owner: ->(c,m){ m.owner }, recipient: ->(c,m){ m.user }
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :users, :foreign_key => "business_id"
    
  validates :name,  presence: true,  length: { minimum: 2, maximum: 30 }
    
end
