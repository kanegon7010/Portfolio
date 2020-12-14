Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  root 'homes#index'
  get 'homes/show'
  resources :users, :only => [:index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
