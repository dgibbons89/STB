Rails.application.routes.draw do
  devise_for :users


  resources :pictures do
  	member do
  		post 'upvote'
  	end
  end
  resources :users
  resources :videos	

  root "pictures#index"
  get "faq" => "pages#faq"
  get "resources" => "pages#resources"


match '/auth/:provider/callback' => 'authentications#create'
get 'auth/failure', to: redirect('/')
get 'signout', to: 'sessions#destroy', as: 'signout'
end
