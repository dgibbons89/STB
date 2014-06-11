Rails.application.routes.draw do
  get 'media/index'

  
  
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

  


  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  root "pictures#index"
  get "faq" => "pages#faq"
  get "facebook" => "pages#facebook"

  get '/auth/:provider/callback' => 'authentications#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'authentications#destroy', as: 'signout'

end
