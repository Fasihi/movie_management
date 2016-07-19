class FavoriteMovie < ActiveRecord::Base
  paginates_per 8
  belongs_to :user
  belongs_to :movie
end
