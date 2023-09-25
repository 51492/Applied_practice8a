class PostCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.post_comments.new(post_comment_params)
    # 上記は下記の省略記載
    # comment = PostComment.new(post_comment_params)
    # comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
    # book = Book.find(params[:book_id])
    # comment = PostComment.find(params[:id])
    # if comment.user != current_user
    #   redirect_to book_path(book)
    # else
    #   comment.destroy
    #   redirect_to book_path(book)
    # end
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
