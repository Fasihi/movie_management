class ReviewsController < ApplicationController
  before_action :set_review, only: [:update, :destroy]

  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review.movie, notice: 'Review was successfully created.' }
      else
        format.html { redirect_to @review.movie, notice: 'Review could not be saved' }
      end
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
      else
        format.html { redirect_to @review.movie, notice: 'Review could not be updated' }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @review.movie, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:user_id, :movie_id, :comment)
    end
end
