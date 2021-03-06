class User < ActiveRecord::Base
  has_many :post
  has_many :ratings, class_name: 'Vote'
  has_many :votes, as: :votable

  validates :email,
  email: true,
  presence: true,
  uniqueness: {case_sensitive: false}

  validates :name,
  presence: true,
  length: { maximum: 20 }

  validates :password,
  presence: true,
  length: {
    minimum: 8,
    maximum: 99,
    too_short: "must be greater than %{count} characters",
    too_long: "must be less than %{count} characters"
  },
  confirmation: true,
  on: :create

  has_secure_password

  
  
  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

end
