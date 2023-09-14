Rails.application.routes.draw do

  resources :topics do
    resources :posts
  end
  root "articles#index"

  resources :articles do
    resources :comments
  end
end