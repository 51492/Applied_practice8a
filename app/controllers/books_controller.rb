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
    # to = Time.current.at_end_of_day
    # from = (to - 6.day).at_beginning_of_day
    # @books = Book.all.sort {|a,b|
    #   b.favorites.where(created_at: from...to).size <=>
    #   a.favorites.where(created_at: from...to).size
    # }
    # @books = Book.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @books = Book.includes(:favorites).sort_by { |book| -book.favorites.count }
    @book_new = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @post_comment = PostComment.new

    #DM機能-----------------------------------------------------------------------------------
      # @currentUserEntry = Entry.where(user_id: current_user.id)
      # #whereメソッドでEntryモデル内でuser_idがcurrent_user.idと一致する複数レコードの中身を全て取り出しハッシュ要素にする
      # @UserEntry = Entry.where(user_id: @user.id)
      # #選択したuser_idと一致する複数レコードの中身を全て取り出しハッシュ要素にする
      # unless @user.id == current_user.id #「選択したユーザーのidがカレントユーザーのidと一致しないとき」の条件を付与
      #   @currentUserEntry.each do |cu| #@currentUserEntryの配列をcuに格納
      #   @UserEntry.each do |u| #@UserEntryの配列をuに格納
      #     if cu.room_id == u.room_id then #前文のeachで格納したcuのroom_idとuのroom_idを照らし合わせてイコールだったらという条件を付与
      #       @is_room = true #「roomが存在する」というインスタンス変数を用意
      #       @room_id = cu.room_id #対象のルームidをインスタンス変数に格納
      #     end
      #   end
      #   end
      # end
      # unless @is_room #既存のroomがない場合という条件を付与(ある場合は前文でtrueが格納されている)
      #   @room = Room.new #新しい空のRoomテーブルを用意して@roomのインスタンス変数に格納
      #   @entry = Entry.new #新しい空のEntryテーブル(中間テーブル)を用意して@entryのインスタンス変数に格納
      # end
    #-----------------------------------------------------------------------------------------
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
