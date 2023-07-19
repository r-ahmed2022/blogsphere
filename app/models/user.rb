class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :postscounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_validation :set_default_value

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def set_default_value
    self.postscounter ||= 0
  end
end
