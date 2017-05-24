Rails.application.routes.draw do

  root :to => "boards#index"
  resources :boards, :only => [:index, :show]

  resource :session, :only => [:new, :create, :destroy]
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"


  resources :users, :only => [:create]
  get "register" => "users#new"
end
