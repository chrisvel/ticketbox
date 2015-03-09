class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(c,m){ m.owner }, recipient: ->(c,m){ m.owner }
  
  attr_accessor :remember_token, :activation_token, :reset_token
  attr_accessor :password_confirmation
  before_save :downcase_email
  before_create :create_activation_digest
  after_initialize :defaults
  
  # Relationships
  has_many :assets, :foreign_key => "owner_id"
  has_many :users, :foreign_key => "owner_id"
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :tickets, :foreign_key => "owner_id"
  has_many :ticket_categories, :foreign_key => "owner_id"
  has_many :asset_locations, :foreign_key => "owner_id"
  has_many :businesses, :foreign_key => "owner_id"
  belongs_to :business, :foreign_key => "business_id"
  has_many :groups, :foreign_key => "owner_id"
  belongs_to :group, :foreign_key => "group_id"
  belongs_to :business, :foreign_key => "business_id"
  has_one :role
  has_one :membership
  
  # Images
  has_attached_file :avatar, :styles => { 
    :medium => "300x300#", 
    :thumb => "100x100#",
  }, 
    :default_url => "/images/no-image.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  
  # Validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username,  presence: true,  length: { minimum:6, maximum: 18 },  uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/, message: "only allows letters and numbers" }
  validates :firstname, presence: false, length: { minimum:3, maximum: 100 }, format: { with: /\A[a-zA-Z ]+\z/, message: "only allows letters" }
  validates :lastname,  presence: false, length: { minimum:3, maximum: 100 }, format: { with: /\A[a-zA-Z ]+\z/, message: "only allows letters" }
  validates :email, presence: true, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :landline_phone, allow_blank: true, length: { is: 10 }, format: { with: /\A[0-9]+\z/, message: "only allows numbers" }
  validates :mobile_phone, allow_blank: true, length: { is: 10 }, format: { with: /\A[0-9]+\z/, message: "only allows numbers" }
  validates :department, allow_blank: true, length: { minimum:3, maximum: 100 }
  validates :position, allow_blank: true, length: { minimum:3, maximum: 100 }
  validates :business_id, presence: false
  validates :leaver, presence: false
  validates :owner_id, presence: false
  
  has_secure_password validations: false
  validates :password, 
    :password_confirmation, 
    :presence => true, 
    :if => :password, 
    length: { minimum: 8 }
    
  ##
  ## scopes
  ##
  
  
  ##
  ##
  ##
  
  def get_user_fullname
    "#{self.lastname}, #{self.firstname}"
  end
  
  def get_owner_fullname
    "#{self.owner.lastname}, #{self.owner.firstname}"
  end
    
  def self.search(search)
    if search
      where('username LIKE ? OR lastname LIKE ?', "%#{search}%", "%#{search}%")
    else
      all
    end
  end
    
  def defaults
    self.leaver ||= 0
  end
    
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver
  end
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private
  
    def downcase_email
      self.email = email.downcase
    end
    
    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
end