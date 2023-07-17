# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'users#index'

  resources :users do 
     resources :posts, only: [:index, :show]
      post '/posts', to: 'posts#index'
    # get '/posts/:id', to: 'posts#show'
  end
  resources :posts, only: [:show]
end
