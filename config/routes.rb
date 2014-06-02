Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :pictures do
  	member do
  		post 'upvote'
  	end
  end
  resources :users
  	

  resources :videos do
    member do
      post 'upvote'
    end
  end

  resources :friends
  get '/index' => 'friends#index'
  get '/login' => 'friends#login'
  

  
  
  root "pictures#index"
  get "faq" => "pages#faq"
  get "resources" => "pages#resources"
  get "facebook" => "pages#facebook"

  get '/auth/:provider/callback' => 'authentications#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'authentications#destroy', as: 'signout'

end
