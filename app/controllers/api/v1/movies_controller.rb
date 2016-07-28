module Api
  module V1
    class MoviesController < ApplicationController
      respond_to :json
      before_action :restrict_access

      def index
        movies = unless params[:title] || params[:actors] || params[:genre]
          Movie.all
        else
          Movie.search_movies(params)
        end
        respond_with movies.page(params[:page])
      end

      def show
        @movie = Movie.find_by_id(params[:id])
        if @movie.present?
          respond_with @movie.details_hash
        else
          respond_with ["error": "No movies present"]
        end
      end

      private

      def restrict_access
        if request && request.headers && request.headers['Authorization']
          return if request.headers['Authorization'] == API_KEY
        end
        head :unauthorized
      end

    end
  end
end
