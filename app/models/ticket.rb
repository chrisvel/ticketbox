class Ticket < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(c,m){ m.owner }, recipient: ->(c,m){ m.user }
  
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :ticket_category, :foreign_key => 'ticket_category_id'
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  self.table_name = "tickets"
  
  validates :issue,  presence: true,  length: { minimum:6, maximum: 300 }
  validates :date_opened,  presence: true
  
  #
  # scopes
  #
  scope :all_unsolved, -> { 
    where("status = ? or status = ? or status = ?", 'OP', 'IP', 'WF')
    .order('severity = "asap" DESC',
           'severity = "high" DESC',
           'severity = "normal" DESC',
           'severity = "low" DESC',
           'date_opened ASC')
   }
   
   scope :all_opened, -> { 
     where("status = ? ", 'OP')
     .order('severity = "asap" DESC',
            'severity = "high" DESC',
            'severity = "normal" DESC',
            'severity = "low" DESC',
            'date_opened ASC')
    }
    
    scope :all_in_progress, -> { 
      where("status = ? ", 'IP')
     }

end
