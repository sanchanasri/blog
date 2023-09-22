Rails.application.routes.draw do
  root "articles#index"
  get '/posts', to: 'posts#index', as: 'all_posts'
  resources :posts do
    resources :post_comments
  end
  resources :articles
  resources :topics do
    resources :posts do
      resources :post_comments
      resources :ratings
      resources :tags, only: [:index, :show, :new, :create, :update] # Define the routes for TagsController here
    end
  end
end

