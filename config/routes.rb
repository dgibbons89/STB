Rails.application.routes.draw do
  

  
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :pictures do
  	member do
  		post 'upvote'
  	end
  end
  resources :users
  	

  
  # get '/auth/:provider/callback' => 'registrationss#create'
  # get 'auth/failure', to: redirect('/')
  # get 'signout', to: 'registrations#destroy', as: 'signout'
  


  match '/auth/:provider/callback' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  root "pictures#index"
  get "faq" => "pages#faq"
  get "terms" => "pages#terms"
  get "resources" => "pages#resources"
  

end
