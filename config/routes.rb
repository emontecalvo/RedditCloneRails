Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: :destroy
  resources :posts, except: :index

  root to: "subs#index"
end
