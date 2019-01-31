class MessagesController < ApplicationController
  before_action :find_chatroom

  def index
    # @messages = @chatroom.messages
    # if @messages.length > 10
    #   @over_ten = true
    #   @messages = @messages[-10..-1]
    # end
    # if params[:m]
    #   @over_ten = false
    #   @messages = @chatroom.messages
    # end
    # if @messages.last
    # if @messages.last.user_id != current_user.id
    #   @messages.last.read = true
    # end
    #  @new_message = Message.new
    #  end
      @messages = Message.where(chatroom: @chatroom)
      @messages.each do |message|
        message.read = true
        message.save!
      end
  end

  def new
    @message = @chatroom.messages.new
  end

  def create
    @message = Message.new(message_params)
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message.chatroom = @chatroom
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.html { redirect_to chatroom_path(@chatroom) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render "chatrooms/show" }
        format.js
      end
    end

    # @message = @chatroom.messages.new(message_params)
    # @message.user = current_user
    # if @message.save
    #   redirect_to chatroom_messages_path(@chatroom)
    # end
  end

  def destroy
    @message.destroy
    redirect_to messages_path
  end

  private

  def find_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def message_params
    params.require(:message).permit(:content, :user_id)
  end
end
