Rails.application.routes.draw do
  root 'users#new'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post 'new', to: 'posts#create'
  resources :users
  resources :posts, :only => [:new, :create, :index]
end
