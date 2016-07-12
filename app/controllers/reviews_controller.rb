class ReviewsController < ApplicationController
  before_action :set_review, only: [:update, :destroy, :edit]
  before_action :find_movie, only: [:create, :edit, :update]

  def create
    @review = @movie.reviews.build

    @created_review = @movie.reviews.new(review_params)
    @created_review.user = current_user
    @created_review.save
  end

  def edit
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review.movie, notice: 'Review was successfully updated.' }
        format.js
      else
        format.html { redirect_to @review.movie, notice: 'Review could not be updated' }
        format.js
      end
    end
  end

  def destroy
    @review.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:comment)
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end
end
