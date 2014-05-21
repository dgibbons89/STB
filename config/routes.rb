Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :pictures do
  	member do
  		post 'upvote'
  	end
  end
  resources :users
  resources :videos	

  resources :friends do
  post 'fb_friends',  on: :collection
  end
  

  
  get "facebook_profile" => "facebook#facebook_profile"
  root "pictures#index"
  get "faq" => "pages#faq"
  get "resources" => "pages#resources"
  get "facebook" => "pages#facebook"

  get '/auth/:provider/callback' => 'authentications#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'authentications#destroy', as: 'signout'

end
