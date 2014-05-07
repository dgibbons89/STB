Rails.application.routes.draw do
  devise_for :users
  resources :pictures
  resources :users
  resources :videos	

  root "pictures#index"
  get "faq" => "pages#faq"
  get "resources" => "pages#resources"



end
