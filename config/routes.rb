Rails.application.routes.draw do
  devise_for :users,
  controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}


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


get 'auth/:provider/callback', to: 'sessions#create'
get 'auth/failure', to: redirect('/')
get 'signout', to: 'sessions#destroy', as: 'signout'
end
