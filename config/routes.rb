Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users

  get "homes/about" => "homes#about", as: "about"

  # get 'books/new'
  # get 'books/create'
  # get 'books/index'
  # get 'books/show'
  # get 'books/destroy'
  resources :books, only: [:new, :index, :show]

  # get 'users/show'
  # get 'users/edit'
  resources :users, only: [:show, :edit]

end

# 以下参考
# resources メソッドは、ルーティングを一括して自動生成してくれる機能