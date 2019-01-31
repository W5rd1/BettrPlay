Rails.application.routes.draw do
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  devise_for :users
  resources :users, only: [:show] do
    member do
      get 'my_challenges', to: 'challenges#my_challenges'
    end
  end
  resources :users, only: [:show]
  resources :disputes, only: [:new]
  resources :deposits, only: [:new, :create] do
    resources :payments, only: [:new, :create]
  end
  resources :challenges do
    get 'host_win', to: 'challenges#host_win', as: :host_win
    get 'host_lost', to: 'challenges#host_lost', as: :host_lost
    get 'set_guest', to: 'challenges#set_guest', as: :set_guest
    get 'guest_left', to: 'challenges#guest_left', as: :guest_left
    member do
      patch 'add_time', to: 'challenges#add_time'
      patch 'leave', to: 'challenges#leave'
    end
  end
  resources :chatrooms do
    resources :messages
  end
  resources :activities

  mount ActionCable.server => "/cable"
  #do
  #  resources :disputes, only: [:new, :create, :show, :delete]
  #end
  # post '/challenges/:id/', to: 'challenges#set_guest', as:
end
