Rails.application.routes.draw do
  devise_for :users
  root 'books#index'
  resources :books do
    resources :reviews, only: :create

    collection do # searchアクションのルーティングを設定する。
      get 'search'
    end

    collection do
      get 'index-search'
    end

    collection do
      get 'praise'
    end
    
  end
end
