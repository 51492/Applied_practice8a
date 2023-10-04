class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @book_new = Book.new
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      # ↓レンダーでindexのviewを表示する前に必要なインスタンスを用意
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    # @books = Book.all
    # @books = Book.includes(:favorited_users).sort_by {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @books = Book.includes(:favorites).sort_by { |book| -book.favorites.count }
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @post_comment = PostComment.new
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    else
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
      else
        render :edit
      end
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.user != current_user
      redirect_to books_path
    else
      book.destroy
      redirect_to books_path
    end

  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

end
