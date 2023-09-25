class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    # 上記は下記の省略記載
    # comment = Favorite.new(book_id: book.id)
    # comment.user_id = current_user.id
    favorite.save
    redirect_to request.referer
    # 同じページにリダイレクト
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
  end

end
