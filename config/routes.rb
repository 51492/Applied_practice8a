Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users

  get "homes/about" => "homes#about", as: "about"

  # get 'books/new'
  # get 'books/create'
  # get 'books/index'
  # get 'books/show'
  # get 'books/destroy'
  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]

  # get 'users/show'
  # get 'users/edit'
  resources :users, only: [:show, :index, :edit, :update]

end

# 以下参考
# resources メソッドは、ルーティングを一括して自動生成してくれる機能