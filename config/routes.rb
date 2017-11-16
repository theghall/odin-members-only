Rails.application.routes.draw do
  root 'posts#index'

  get '/login', to: "sessions#new"
  delete '/logout', to: "sessions#destroy"

  resources :sessions, only: [:create]
  resources :posts, only: [:create, :index, :new, :update]
end
