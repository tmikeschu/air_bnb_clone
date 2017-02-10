Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions,  only: [:new]
  resources :users,     only: [:new, :create, :show] do
    resources :couches
    scope module: :users do
      resources :reservations, only: [:index]
      resources :couch_photos, only: [:new, :create, :show]
    end
  end
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  root to: "home#show"

  get "/search", to: "search/available_couches#index"
  resources :reservations, only: [:create]
end
