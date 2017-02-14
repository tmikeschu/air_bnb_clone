Rails.application.routes.draw do
  root to: "home#show"

  resources :couches,   only: [:show]
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
end
