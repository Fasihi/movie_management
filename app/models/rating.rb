class Rating < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  scope :for_movie, -> (movie) { where(movie_id: movie.id) }
end
