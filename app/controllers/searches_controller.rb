class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      render "/layouts/search_result"
    else
      @books = Book.looks(params[:search], params[:word])
      render "/layouts/search_result"
    end
  end

end

# 以下参考

# Rails 検索機能の実装 - Qiitaブログ
  # https://qiita.com/hapiblog2020/items/6c2cef49df5616da9ae3
    # ①下記コードにて検索フォームからの情報を受け取っています。
    # 　検索モデル→params[:range]
    # 　検索方法→params[:search]
    # 　検索ワード→params[:word]

    # ②if文を使い、検索モデルUserorBookで条件分岐させます。

    # ③looksメソッドを使い、検索内容を取得し、変数に代入します。
    # 検索方法params[:search]と、検索ワードparams[:word]を参照してデータを検索し、
    # 1：インスタンス変数@usersにUserモデル内での検索結果を代入します。
    # 2：インスタンス変数@booksにBookモデル内での検索結果を代入します。

# 【Ruby on Rails】検索機能をGemなしで実装｜簡単なメモアプリにAjaxで検索結果を表示させよう - Youtube
  # https://www.youtube.com/watch?v=z57EKLjf4xM