Microtube::Application.routes.draw do
  resources :posts

  resources :users, except: [:index]

  resources :user_sessions, only: [:new, :create, :destroy]
  get 'login', to: "user_sessions#new"
  delete 'logout', to: "user_sessions#destroy"

  resources :videos do
    resources :posts, only: :create
  end

  root to: "videos#index"
end
