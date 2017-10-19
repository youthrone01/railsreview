class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :events
  has_many :attends
  has_many :attend_events, through: :attends, source: :event
  has_many :comments

  validates :first_name, :last_name, :city, presence: true
  validates :state, presence: true, length: {is: 2}
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  
  before_save :email_lowercase

  def email_lowercase
    email.downcase!
  end
end
