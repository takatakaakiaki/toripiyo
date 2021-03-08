Rails.application.routes.draw do
  get 'tweets/index'
  root to: "tweets#index"
end
