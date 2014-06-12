Rails.application.routes.draw do
  

  
  
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  resources :pictures do
  	member do
  		post 'upvote'
  	end
  end
  resources :users
  	

  

  


  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  root "pictures#index"
  get "faq" => "pages#faq"
  get "terms" => "pages#terms"
  get "resources" => "pages#resources"
  

end
