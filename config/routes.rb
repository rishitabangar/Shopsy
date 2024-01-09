Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'profile/show'
  
  devise_for :users, controllers: {registrations: 'registrations'}
 
  resources :addresses

  resources :categories
  # get    '/login',   to: 'sessions#new'
  # post   '/login',   to: 'sessions#create'
  # delete '/logout',  to: 'sessions#destroy'

  resource :users do
    resource :carts 
  end

  root "products#index"

  resources :products

  resources :cart_items
  get "/decrement", to: "cart_items#decrement"
  get "/increment", to: "cart_items#increment"
  get "/all_items", to: "carts#all_items"

  resources :order_items
  get "/increment_items", to: "order_items#increment_items"
  get "/decrement_items", to: "order_items#decrement_items"

  resource :users do 
    resources :orders
  end

   

end
