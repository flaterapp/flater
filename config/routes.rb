Rails.application.routes.draw do
  # FOREST ADMIN
  mount ForestLiana::Engine => '/forest'

  # FLATS
  resources :flats, only: [:index, :show, :new, :edit, :create, :update] do
    resources :rentals, only: [:index, :show, :new, :edit, :create] do
      member do
        get 'organize_visit', to: 'rentals#organize_visit'
        post 'select_tenant', to: 'rentals#select_tenant'
        post 'confirm_tenant', to: 'rentals#confirm_tenant'
      end
    end
  end

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
  get 'my_visits', to: 'pages#my_visits'

  #CHATROOM & CONVERSATIONS
  resources :chat_rooms, only: %i[index show create destroy] do
    resources :messages, only: %i[create]
  end
  resources :conversations, only: %i[index show create destroy] do
    resources :direct_messages, only: %i[create update]
  end

  # USERS
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # HOME
  root to: 'pages#home'

end
