Rails.application.routes.draw do
  devise_scope :user do
    get 'logout', to: 'session#destroy', as: :logout
  end
  
  devise_for :users
  root to: "users#index", controllers: { session: 'session' }

  resources :users do
    resources :posts do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
