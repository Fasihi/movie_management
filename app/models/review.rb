class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user

  has_many :reported_reviews, dependent: :destroy

  validates :comment, presence: true, length: { minimum: 5 }
end
