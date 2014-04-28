Rails.application.routes.draw do


  root "pages#home"
  get "faq" => "pages#faq"
  get "resources" => "pages#resources"



end
