Rails.application.routes.draw do
  use_doorkeeper
  root to: "home#show"

  resources :couches,   only: [:show]
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :users, only: [:new, :create, :show] do
    scope module: :users do
      resources :reservations, only: [:index]
      resources :couches, only: [:new, :create, :show]
    end
  end

  resources :couches, only: [:show] do
    scope module: :couches do
      resources :photos, only: [:new, :create]
      resources :nights, only: [:new, :create]
    end
  end

  get "/search", to: "search/available_couches#index"

  resources :reservations, only: [:create]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show]
    end
  end
end
