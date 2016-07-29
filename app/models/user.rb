class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  def author?(id)
    self == Post.find(id).user
  end
end