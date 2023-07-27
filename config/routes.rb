Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :posts do
      resources :comments
      resources :likes
    end
  end
root 'users#index'
get 'search', to: 'users#index', as: :your_search
end