Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books do
    resources :reviews, only: :create
    collection do
      get 'search'
    end
  end
end
