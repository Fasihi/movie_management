module ReviewsHelper
  def review_owner?(review)
    review.user == current_user
  end
end
