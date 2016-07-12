class Review < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  validates :comment, presence: true, length: { minimum: 5 }
end
