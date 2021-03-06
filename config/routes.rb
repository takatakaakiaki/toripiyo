Rails.application.routes.draw do
  devise_for :users
  get 'tweets/index'
  root to: "tweets#index"

  resources :tweets do
    collection do
      get 'search'
    end
    resources :comments, only: :create
  end

  get '/tweets/category/:id', to: "tweets#category"

end