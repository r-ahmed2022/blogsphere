class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250, too_long: '250 characters in post is the maximum allowed.' }
  validates :commentscounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likescounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_posts_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.increment!(:postscounter)
  end
end
