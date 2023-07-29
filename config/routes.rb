Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root 'users#index'
  devise_for :users
  resources :users do
    resources :posts do
      resources :comments, only: [:index, :new, :create, :destroy]
      resources :likes
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      #mount_devise_token_auth_for 'User', at: 'auth'
       resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end

get 'search', to: 'users#index', as: :your_search

end