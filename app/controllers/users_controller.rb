class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id]) # Userモデルの中から選択したユーザーのid(主キー)に対応する一つのレコードの中身を全て取り出しハッシュ要素にする
    @books = @user.books
    @book_new = Book.new
    @users_f = User.where.not(id: current_user.id)

    #DM機能-----------------------------------------------------------------------------------
      @currentUserEntry = Entry.where(user_id: current_user.id)
      #whereメソッドでEntryモデル内でuser_idがcurrent_user.idと一致する複数レコードの中身を全て取り出しハッシュ要素にする
      @UserEntry = Entry.where(user_id: @user.id)
      #選択したuser_idと一致する複数レコードの中身を全て取り出しハッシュ要素にする
      unless @user.id == current_user.id #「選択したユーザーのidがカレントユーザーのidと一致しないとき」の条件を付与
        @currentUserEntry.each do |cu| #@currentUserEntryの配列をcuに格納
        @UserEntry.each do |u| #@UserEntryの配列をuに格納
          if cu.room_id == u.room_id then #前文のeachで格納したcuのroom_idとuのroom_idを照らし合わせてイコールだったらという条件を付与
            @is_room = true #「roomが存在する」というインスタンス変数を用意
            @room_id = cu.room_id #対象のルームidをインスタンス変数に格納
          end
        end
        end
      end
      unless @is_room #既存のroomがない場合という条件を付与(ある場合は前文でtrueが格納されている)
        @room = Room.new #新しい空のRoomテーブルを用意して@roomのインスタンス変数に格納
        @entry = Entry.new #新しい空のEntryテーブル(中間テーブル)を用意して@entryのインスタンス変数に格納
      end
    #-----------------------------------------------------------------------------------------

  end

  def index
    @user = current_user
    @users = User.all
    @book_new = Book.new
    @users_f = User.where.not(id: current_user.id)
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      render :edit
    end
  end

  def followeds
    user = User.find(params[:id])
    @users = user.followeds
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
