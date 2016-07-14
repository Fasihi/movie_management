class ReportedReviewsController < ApplicationController
  def create
    unless ReportedReview.already_reported?(current_user.id, params[:review_id])
      @review = Review.find(params[:review_id])
      @report = @review.reported_reviews.new
      @report.user_id = current_user.id
      @report.save
      @review.report_count += 1
      @review.save
   end
  end
end
