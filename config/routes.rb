Yata::Application.routes.draw do
  resources :todos

  root to: "home#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy"
end
