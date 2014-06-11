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
  
  

end
