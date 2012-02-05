Yata::Application.routes.draw do

  resources :todos
  resources :users
  resources :authorizations, only: [ :destroy ]

  root to: "sessions#new"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy", as: "logout"
  match "/profile" => "users#profile", as: "profile"

end
