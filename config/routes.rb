Rails.application.routes.draw do
  devise_for :users
  root "articles#index"
  get '/posts', to: 'posts#index', as: 'all_posts'
  resources :posts do
    resources :post_comments
  end
  resources :articles
  resources :topics do
    resources :posts do
      member do
        delete 'remove_image' , to: 'posts#remove_image'
      end
      post 'mark_as_read', on: :member
      resources :post_comments do
        resources :user_comment_ratings
      end
      resources :ratings
      resources :tags, only: [:index, :show, :new, :create, :update]
      member do
        delete 'remove_image'
      end
    end
  end
end

