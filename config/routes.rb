Rails.application.routes.draw do
  

  
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :users

  #match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :pictures do
  	member do
  		post 'upvote'
  	end
  end
  
  	

  
  get '/auth/:provider/callback' => 'users#finish_signup'
  # get 'auth/failure', to: redirect('/') 
  # get 'signout', to: 'registrations#destroy', as: 'signout'
  


  root "pictures#index"
  get "faq" => "pages#faq"
  get "terms" => "pages#terms"
  get "resources" => "pages#resources"
  

end
