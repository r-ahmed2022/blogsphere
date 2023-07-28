class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :name, presence: true
  validates :postscounter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  before_validation :set_default_value
  include DeviseTokenAuth::Concerns::User

  ROLES = %i[admin default].freeze

  def is?(role)
    self.role == role.to_s
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def set_default_value
    self.postscounter ||= 0
  end

  def self.search_by_name(query)
    where('name ILIKE ?', "%#{query}%")
  end
end
