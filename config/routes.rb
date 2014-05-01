Rails.application.routes.draw do
  devise_for :users
  resources :pictures
  resources :users
  resources :videos	

  root "pages#home"
  get "faq" => "pages#faq"
  get "resources" => "pages#resources"



end
