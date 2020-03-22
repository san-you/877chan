Rails.application.routes.draw do
  root 'boards#index'

  resources :categories
  resources :comments
  resources :boards

  devise_for :users, skip: [:registrations]
  devise_scope :user do
    get '/users/cancel', to: 'devise/registrations#cancel', as: :cancel_user_registration
    get '/users/sign_up', to: 'devise/registrations#new', as: :new_user_registration
    get '/users/edit', to: 'devise/registrations#edit', as: :edit_user_registration
    patch '/users', to: 'devise/registrations#update', as: :user_registration
    put '/users', to: 'devise/registrations#update', as: nil
    delete '/users', to: 'devise/registrations#delete', as: nil
    post '/users/sign_up', to: 'devise/registrations#create', as: :post_user_registration
  end

  get 'search/index'
  post 'search/search'
  get 'pages/show'

  get '*not_found' => 'application#routing_error'
  post '*not_found' => 'application#routing_error'
end
