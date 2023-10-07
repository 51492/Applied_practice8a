Rails.application.routes.draw do

  get 'searches/search'
  root to: "homes#top"
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }
  # deviseを使用する際にURLとしてusersを含むことを示している

  get "home/about" => "homes#about", as: "about"
  # resources :homes, only: [:about, :destroy]

  get "search" => "searches#search"

  # get 'books/new'
  # get 'books/create'
  # get 'books/index'
  # get 'books/show'
  # get 'books/destroy'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  # get 'users/show'
  # get 'users/edit'
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :followeds, on: :member
    get :followers, on: :member
  end

  # DM機能のためのルーティング
  # resources :users, only: [:show, :edit, :update] 上で書いてるから不要？
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]

end

# 以下参考
# resources メソッドは、ルーティングを一括して自動生成してくれる機能