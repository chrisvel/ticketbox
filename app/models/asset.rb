class Asset < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(c,m){ m.owner }, recipient: ->(c,m){ m.user }
  
  belongs_to :user
  belongs_to :asset_location
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  
  validates :serial,  presence: true,  length: { minimum: 2, maximum: 30 }
  validates :brand,  presence: true,  length: { minimum:2, maximum: 18 }, format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "only allows letters and numbers" }
  validates :kind,  presence: true,  length: { minimum:2, maximum: 18 }, format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "only allows letters and numbers" }
  validates :comment,  allow_blank: true,  length: { minimum:6, maximum: 300 }
  validates :ware,  allow_blank: true,  length: { minimum:2, maximum: 30 }

  def self.search(search)
    if search
      joins('LEFT JOIN users ON users.id = assets.user_id')
      .where('serial LIKE ? OR users.lastname LIKE ?', 
        "%#{search}%", "%#{search}%")
    else
      all
    end
  end
  
end
