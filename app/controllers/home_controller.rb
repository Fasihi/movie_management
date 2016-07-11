class HomeController < ApplicationController
  def index
    @latest = Movie.latest_movies.first(3)
    @featured = Movie.featured_movies.first(3)
  end
end
