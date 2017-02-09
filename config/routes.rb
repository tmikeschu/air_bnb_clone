Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions,  only: [:new]
  resources :users,     only: [:new, :create, :show] do
    resources :couches
  end
  resources :couches, only: [:show]
  resources :couches, only: [:show] do
    resources :nights, only: [:new, :create]
    scope module: :users do
      resources :reservations, only: [:index]
    end
  end
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  root to: "home#show"
  get "/search", to: "search/available_couches#index"
  resources :reservations, only: [:create]
end
