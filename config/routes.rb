Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations', sessions: :sessions }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'top#index'

  resources :users, only: [:index, :show]

  resources :reactions, only: [:create]

  resources :matching, only: [:index]

  resources :chat_rooms, only: [:create, :show]
end
