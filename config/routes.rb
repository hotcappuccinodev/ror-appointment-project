# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
        registerations: 'users/registerations'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :reservations, only: [:index, :show]
      resources :vehicles, only: [:index, :show, :create] do
      resources :reservations, only: [ :create, :destroy]
      end
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
