class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attend, dependent: :destroy
  has_many :attend_users, through: :attend, source: :user
  has_many :comments, dependent: :destroy

  validates :name, :city, :date, presence:true
  validates_date :date, on_or_after: lambda { Time.now }
  validates :state,  presence:true, length: {is: 2}

  
end
