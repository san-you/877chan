Rails.application.routes.draw do
  root 'boards#index'
  resources :categories
  resources :comments
  resources :boards
  devise_for :users
  get 'search/index'
  post 'search/search'
  get 'pages/show'

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
