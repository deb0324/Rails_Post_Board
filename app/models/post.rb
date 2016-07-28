class Post < ActiveRecord::Base
  has_many :comments
  has_many :connections
  has_many :categories, through: :connections

  belongs_to :user
end