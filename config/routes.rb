Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: 'toppages#index'

get 'login', to: 'sessions#new'
post 'login', to: 'sessions#create'
delete 'logout', to: "sessions#destroy"


get 'signup', to: 'users#new'
resources :users, only: [:index, :show, :new, :create, :likes] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end

  resources :microposts, only: [ :show, :new, :create, :destroy] 
  resources :relationships, only: [:create, :destroy]
  resources :like_microposts, only:[:create, :destroy]

end
