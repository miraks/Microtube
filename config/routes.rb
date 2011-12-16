Microtube::Application.routes.draw do
  resources :videos

  resources :users, except: [:index]

  resources :user_sessions, only: [:new, :create, :destroy]
  get 'login', to: "user_sessions#new"
  delete 'logout', to: "user_sessions#destroy"
end
