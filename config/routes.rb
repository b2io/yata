Yata::Application.routes.draw do
  scope "api" do
    resources :lists do
      collection { post :sort }
    end
    resources :todos do
      collection { post :sort }
    end
    resources :authorizations
    resources :users
    resources :checklist_items
  end

  root to: "pages#index"

  match "/auth/:provider/callback" => "sessions#create"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy", as: "logout"
  match "/todos" => "pages#todos", as: "todos"
  match "/profile" => "pages#profile", as: "profile"

end
