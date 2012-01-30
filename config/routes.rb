Yata::Application.routes.draw do

  resources :todos

  root to: "sessions#new"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy", as: "logout"

end
