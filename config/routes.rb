Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions,  only: [:new]
  resources :users,     only: [:new, :create, :show] do
    scope module: :users do
      resources :couches
    end
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
