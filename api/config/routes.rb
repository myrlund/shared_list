Api::Application.routes.draw do
  
  resources :roles
  resources :lists do
    resources :items do
      member do
        put :set_status
      end
    end
    
    # Subscription routes
    member do
      post :add_subscriber
      delete :remove_subscriber
    end
  end

  # User and auth
  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  
  resources :user_sessions
  resources :users

  root :to => "lists#index"
  
end
