class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  def author?(id)
    self == Post.find(id).user
  end

  validates :username, :password, presence: true
  validates :password, :username, length: {minimum: 2}
  validates :password, :username, length: {maximum: 20}
  
end