class TicketCategory < ActiveRecord::Base
  #include PublicActivity::Model
  #tracked owner: Proc.new{ |controller, model| controller.current_user }
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :tickets
  
  validates :name,  presence: true,  length: { minimum: 2, maximum: 30 }
  
end
