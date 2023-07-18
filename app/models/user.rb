class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  validates :name, :photo, :bio, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # before_validation :set_default_posts_counter

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  private

  def set_default_posts_counter
    self.post_counter ||= 0
  end
end
