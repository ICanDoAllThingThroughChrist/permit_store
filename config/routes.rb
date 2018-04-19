Rails.application.routes.draw do
  
  get 'admin' => 'admin#index'
  resources :sites
   
  resources :orders 
  get '/orders/:id' => 'orders#toggle_cancellation', :as => 'cancel_site'
  post '/orders/:id', to: 'orders#toggle_cancellation'
  get '/admin/manual_ship' => 'admin#manual_ship', :as => 'permits_to_be_shipped'
  
  root 'sessions#new'
  resources :tasks
  resources :permits do 
    resources :tasks 
  end
  
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/login' => 'sessions#new', :as => 'login'
  post '/login', to: 'sessions#create'
  get '/logout' => 'sessions#destroy', :as => 'logout'
  get '/signup' => 'users#new', :as => 'signup'

  resources :users
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
