class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create] #deviseのメソッド「authenticate_user!」で、onlyメソッドで指定した特定のアクション(ここではcreate)を実行する前にカレントユーザーがログイン状態かどうかを判断する

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present? #user_idがcurrent_user.idで、form_withで送られてきたmessageを含む全てのメッセージに対してmessageキーとroom_idキーが存在しますか？
      # @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      # redirect_to "/rooms/#{@message.room_id}"
      @message = Message.new(message_params)
      @message.save
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end


private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :content).merge(user_id: current_user.id)
  end

end
