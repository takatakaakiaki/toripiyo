Rails.application.routes.draw do
  devise_for :users
  get 'tweets/index'
  root to: "tweets#index"

  resources :tweets

  get '/tweets/category/:id', to: "tweets#category"

end
