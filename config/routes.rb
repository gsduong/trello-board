Rails.application.routes.draw do

  root :to => 'boards#index'

  resources :users, :only => [:create, :show]
  get     '/signup',  to: 'users#new'
  get     '/login',   to: 'sessions#new'
  post    '/login',   to: 'sessions#create'
  delete  '/logout',  to: 'sessions#destroy'

  resources :boards, :only => [:index, :new, :create, :show] do
    resources :cards, :only => [:new, :edit, :create, :update]
  end

  namespace :admin do
    resources :boards, only: [:show, :edit, :update, :destroy] do
      resources :members, only: [:new, :create, :destroy]
      resources :lists, only: [:new, :create, :edit, :update, :destroy]
      resources :cards, only: [:new, :create, :edit, :update, :destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
    end
  end

end
