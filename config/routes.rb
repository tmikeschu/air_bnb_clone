Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :sessions,  only: [:new]
  resources :users,     only: [:new, :create, :show]
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  root to: "home#show"
end
