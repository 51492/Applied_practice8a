class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @room = Room.create #フォームの@roomから送られてきたパラメータをここで受け取りcreateする(なぜusersのshowでつくったのにここ(roomsコントローラ)に送られる？アソシエーションしてるから？)
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id) #カレントユーザーのエントリーテーブルをcreate
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)) #requireでデータオブジェクト(領域)を指定、permitで取得するデータのキーを指定している。mergeで取得した二つのキーにroom_idのキーを追加している。これにより相手側の情報を持ったEntryテーブルをcreateできる。
    redirect_to "/rooms/#{@room.id}" #createされたルームに遷移
  end
  
  def show
    @room = Room.find(params[:id]) #既存のルームをfindで探してインスタンス変数に格納
    if Entry.where(user_id: current_user.id, room_id: @room.id).present? #Entryテーブル内にuser_idがcurrent_userのidで、current_userと相手間のroom_idが取得されたものが存在しますか？
      @messages = @room.messages #アソシエーションで設定したMessagesテーブルのデータをハッシュとしてインスタンス変数に格納
      @message = Message.new #新しいmessageを作成するための空のモデルを用意してインスタンス変数に格納
      @entries = @room.entries #アソシエーションで設定したEntriesテーブルのデータをインスタンス変数に格納
    else #ルームが存在しない場合
      redirect_back(fallback_location: root_path) #前のページにリダイレクトする
    end
  end
  
end

# 以下参考
  
  # RailsでややこしいDM機能を1万字でくわしく解説してみた
    # https://qiita.com/bindingpry/items/6790c91f374acc25bea2#users_controller
  
  # Rails DM機能の実装
    # https://zenn.dev/goldsaya/articles/71758cf3024dc1