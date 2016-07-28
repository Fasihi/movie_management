class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :reported_reviews, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 2000 }

  def reported_by?(user_id)
    self.reported_reviews.exists?(user_id)
  end
end
