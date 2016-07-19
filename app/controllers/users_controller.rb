class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:my_profile]
  def show
    @user = User.find(params[:id])
    @favorite_movies = @user.favorite_movies.page(params[:page])
  end

  def my_profile
    @user = current_user
    @favorite_movies = @user.favorites.page(params[:page])
  end
end
