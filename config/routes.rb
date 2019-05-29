Rails.application.routes.draw do
  

  #Routes for Flats and Rentals
  resources :flats, only: [:index, :show, :new, :edit, :create, :update] do
    resources :rentals, only: [:index, :show, :new, :edit, :create]
  end
  



  #Routes for Tasks and Assignments
  
  # TASKS
  resources :tasks, only: [:index, :show, :new, :edit, :create, :update] do
    resources :assignments, only: [ :index, :new, :create, :confirmation ]
  end
  
  # ASSIGNMENTS
  resources :assignments, only: [ :show, :edit, :update, :destroy ]  do
  	member do
      patch 'valid'
      patch 'reject'
  	end
  end
  
  # CUSTOM PAGES
  get 'dashboard', to: 'pages#dashboard'
  get 'my-tasks', to: 'tasks#mytasks'
  get 'my-applications', to: 'rentals#my_applications'

  # USERS
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  # HOME
  root to: 'pages#home'

end
