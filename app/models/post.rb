class Post < ActiveRecord::Base
  has_many :comments
  has_many :connections
  has_many :categories, through: :connections

  belongs_to :user


  validates :title, :content, presence: {message: "cannot be blank"}
  validates :title, :content, length: {minimum: 1, message: "is too short, minimum 1 character" }
  
end