Rails.application.routes.draw do
  devise_for :users
  resources :pictures
  resources :users
  resources :videos	

  root "pictures#index"
  get "faq" => "pages#faq"
  get "resources" => "pages#resources"

  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]


end
