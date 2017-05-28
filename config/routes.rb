Rails.application.routes.draw do

  root :to => "boards#index"

  resources :users, :only => [:create, :show]
  get     '/signup',  to: 'users#new'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

end
