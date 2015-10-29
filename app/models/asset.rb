class Asset < ActiveRecord::Base
  include PublicActivity::Model
  tracked
  #tracked user: ->(c,m){ m.user }, recipient: ->(c,m){ m.user }

  belongs_to :asset_location
  belongs_to :owner, :class_name => 'User', :foreign_key => 'owner_id'
  belongs_to :user, :class_name => 'User', :foreign_key => 'user_id'

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

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      assets = Asset.all.joins(:user)
      assets.each do |asset|
        csv << [asset.id,
                asset.serial,
                asset.brand,
                asset.kind,
                asset.date_acquired,
                asset.user.fullname,
                asset.comment,
                asset.ware,
                asset.asset_location.name,
                asset.recycled,
                asset.owner.fullname
                ]
      end
    end
  end

end
