class ChatroomsController < ApplicationController
  before_action :find_chatroom, only: [:destroy]

  def index
      @chatrooms = Chatroom.where(receiver: current_user)
      @chatrooms += Chatroom.where(sender: current_user)
  end

  def show
    @chatrooms = Chatroom.where(receiver: current_user)
    @chatrooms += Chatroom.where(sender: current_user)

    @chatroom = Chatroom.includes(messages: :user).find(params[:id])
    unless current_user == @chatroom.sender || current_user == @chatroom.receiver
      redirect_to chatrooms_path
      flash[:alert] = "Not allowed here mate"
    end
  end

  def create
    if Chatroom.between(params[:sender_id], params[:receiver_id]).present?
      @chatroom = Chatroom.between(params[:sender_id], params[:receiver_id]).first
    else
      @chatroom = Chatroom.create!(chatroom_params)
    end
    redirect_to chatroom_messages_path(@chatroom)
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:receiver_id, :sender_id)
  end

  def find_chatroom
    @chatroom = Message.find(params[:id])
  end
end
