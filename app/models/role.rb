class Role < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(c,m){ m.owner }, recipient: ->(c,m){ m.user }
  
  has_many :users
  
end
