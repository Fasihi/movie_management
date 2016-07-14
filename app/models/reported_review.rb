class ReportedReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  def self.already_reported?(user,review)
    ReportedReview.exists?(user_id: user, review_id: review)
  end
end
