class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy, :update, :create]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :set_actors, only: [:new, :edit, :create, :update]

  def index
    @movies = Movie.get_movies(params[:filter])
    @movies = @movies.page(params[:page])
  end

  def show
    @review = @movie.reviews.build
    @rating = @movie.get_ratings(current_user) if user_signed_in?

    respond_to do |format|
      format.html
      format.json { render json: @movie }
    end
  end

  def new
    @movie = Movie.new
  end

  def edit
    @selected_values = @movie.actors.pluck(:id)
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :trailer, :description, :genre, :release_date, :duration, :approved, :featured, actor_ids: [], posters_attributes: [:id, :image, :_destroy])
    end

    def set_actors
      @actors = Actor.all
    end
end
