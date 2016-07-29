Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :movies do
    resources :reviews, only: [:create, :update, :destroy, :edit]
    resources :ratings, only: [:create, :update, :destroy]
  end

  resources :reviews, only: [] do
    resources :reported_reviews, only: [:create]
  end

  devise_for :users

  resources :users, only: [:show]

  resources :movies, only: [] do
    resources :favorite_movies, only: [:create]
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :movies, only: [:show, :index]
    end
  end


  get '/my_profile', to: 'users#my_profile'

  root 'home#index'
end
