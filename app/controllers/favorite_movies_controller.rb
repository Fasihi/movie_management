class FavoriteMoviesController < ApplicationController
  before_action :set_movie, only: [:create]

  def create
    unless @movie.favorite_of?(current_user)
      @favorite = current_user.favorites.create(movie: @movie)
    end
  end

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
