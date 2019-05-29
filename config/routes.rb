Rails.application.routes.draw do
  
  # TASKS
  resources :tasks, only: [:index, :show, :new, :edit, :create, :update] do
    resources :assignments, only: [ :index, :new, :create ]
  end
  
  # ASSIGNMENTS
  resources :assignments, only: [ :show, :edit, :update, :destroy ]  do
  	member do
      patch 'valid'
      patch 'reject'
  	end
  end
  
  # CUSTOM PAGES
  get 'my-tasks', to: 'tasks#mytasks'
  get 'dashboard', to: 'pages#dashboard'

  # USERS
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  # HOME
  root to: 'pages#home'

end
