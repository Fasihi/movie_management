class RatingsController < ApplicationController
  before_action :set_rating, only: [:update, :destroy]
  before_action :set_movie

  def create
    @rating = @movie.ratings.new(rating_params)
    @rating.user_id = current_user.id
    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rating, notice: 'Rating was successfully created.' }
        format.json { render json: { rating: @rating, average: @movie.get_average, id: @rating.id } }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { render json: { rating: @rating, average: @movie.get_average } }
      else
        format.html { render :edit }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @rating.destroy
    respond_to do |format|
      format.html { redirect_to ratings_url, notice: 'Rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_rating
      @rating = Rating.find(params[:id])
    end

    def rating_params
      params.require(:rating).permit(:score)
    end

    def set_movie
      @movie = Movie.find(params[:movie_id])
    end
end
