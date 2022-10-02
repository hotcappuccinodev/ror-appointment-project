# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: {
        registrations: 'users/registrations',
        sessions: 'users/sessions'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :reservations, only: [:index, :show]
      resources :vehicles, only: [:index, :show, :create, :update, :destroy] do
      resources :reservations, only: [ :create, :destroy]
      end
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
