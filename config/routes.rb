Rails.application.routes.draw do
  root to: "users#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end
end
