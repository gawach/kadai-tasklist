Rails.application.routes.draw do
  
  root to: 'tasks#index'
  
  resources :tasks, only: [:new, :show, :edit, :create, :update, :delete]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]
end