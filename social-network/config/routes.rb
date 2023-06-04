Rails.application.routes.draw do
  resources :friendships
  resources :friendship_requests
  resources :users do 
    resources :profiles
    resources :posts do 
      resources :comments
    end
  end

  root "news_feed#index"
end
