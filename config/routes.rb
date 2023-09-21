Rails.application.routes.draw do

  root to: "homes#top"
  devise_for :users, controllers: {
    sessions: 'devise/sessions',
    registrations: 'devise/registrations'
  }
  # deviseを使用する際にURLとしてusersを含むことを示している

  get "home/about" => "homes#about", as: "about"
  # resources :homes, only: [:about, :destroy]

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