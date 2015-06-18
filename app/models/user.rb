class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # own stuff
  include PublicActivity::Model
  tracked
  #tracked owner: Proc.new{ |controller, model| controller.current_user }
    
  # Relationships
  has_many :assets, :foreign_key => "owner_id"
  has_many :users, :foreign_key => "id"
  has_many :tickets, :foreign_key => "owner_id"
  has_many :ticket_categories, :foreign_key => "owner_id"
  has_many :asset_locations, :foreign_key => "owner_id"
  has_many :businesses, :foreign_key => "owner_id"
  belongs_to :business, :foreign_key => "business_id"
  has_many :groups, :foreign_key => "owner_id"
  belongs_to :group, :foreign_key => "group_id"
  belongs_to :business, :foreign_key => "business_id"
  has_one :membership
  
  # Images
  has_attached_file :avatar, :styles => { 
    :medium => "300x300#", 
    :thumb => "100x100#",
  }, 
    :default_url => "/images/no-image.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  #def get_user_fullname
  #  "#{self.lastname}, #{self.firstname}"
  #end
  
  #def get_user_fullname
  #  "#{self.user.lastname}, #{self.user.firstname}"
  #end
    
  #def self.search(search)
  #  if search
  #    where('username LIKE ? OR lastname LIKE ?', "%#{search}%", "%#{search}%")
  #  else
  #    all
  #  end
  #end
    
  def defaults
    self.leaver ||= 0
  end

  private
  
    #
  
end
