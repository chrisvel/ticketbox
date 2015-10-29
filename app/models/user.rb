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
  has_one :membership
  has_many :profiles, class_name: "User", :foreign_key => "profile_id"
  belongs_to :user, foreign_key: :profile_id

  # Validations
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :firstname, length: { maximum: 20 }
  validates :lastname, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 250 },
                    format: { with: EMAIL_REGEX },
                    uniqueness: true
  validates :password, length: { minimum: 8 }

  # Images
  has_attached_file :avatar, :styles => {
    :medium => "300x300#",
    :thumb => "100x100#",
  },
    :default_url => "/images/no-image.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Simple search for username or lastname
  def self.search(term)
    if term
      where('username LIKE ? OR lastname LIKE ?', "%#{term}%", "%#{term}%")
    else
      all
    end
  end

  # Set a user initially as a non leaver
  def defaults
    self.leaver ||= 0
  end

  # Return the full name of the user
  def fullname
    "#{self.lastname}, #{self.firstname}"
  end

end
