class HomeController < ApplicationController
  def index
    movie = Movie.includes(:ratings, :posters)
    @latest = movie.latest_movies.approved.first(4)
    @featured = movie.featured_movies.approved.first(4)
    @top = movie.top_movies.latest_movies.approved.first(4)
  end
end
