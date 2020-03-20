Rails.application.routes.draw do
  root 'boards#index'
  resources :categories
  resources :comments
  resources :boards
  devise_for :users
  get 'search/index'
  post 'search/search'
  get 'pages/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
