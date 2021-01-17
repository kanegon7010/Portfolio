Rails.application.routes.draw do
  get 'microposts/create'
  get 'microposts/destroy'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'homes#index'
  get 'homes/show'
  resources :users, only: [:index, :show] do 
    member do
      get :followings, :followers
      resource :cv, only: [:show, :new, :create, :edit, :update]
    end
  end 
  
  resources :messages, only: [:create, :destroy]
  resources :rooms, only: [:index, :create, :show]
  resources :relationships, only: [:create, :destroy]
  resources :microposts, only: [:show, :create, :destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
