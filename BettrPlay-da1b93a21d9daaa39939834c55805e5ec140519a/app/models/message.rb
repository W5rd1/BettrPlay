class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user
  validates :content, presence: true, allow_blank: false
  after_create :broadcast_message

  def message_time
    created_at.strftime("%H:%M %d-%m-%y")
  end

  def new_challenge_message(message, user, chatroom, challenge)
    @message = message
    @message.content = "Hi #{chatroom.other_person(user, chatroom).username} we are now in challenge for #{challenge.game} on #{challenge.platform}.
    The wager is £#{challenge.stake}. We have 24hrs to play unless you extend! My Gamer Tag for this is #{challenge.guest_gamertag? ? challenge.guest_gamertag : '(ask for my Gamer Tag!)' } add me
    on the relevant network (PSN, Xbox Live, Steam etc.) so we can find each other. Let's play!"
    @message.user = user
    @message.chatroom = chatroom
    @message.save
    return @message
  end

  def guest_left_message(message, user, chatroom, challenge)
    @message = message
    @message.content = "Hi #{challenge.host.username}, #{user.username} just left your #{challenge.game} challenge... Chicken! Don't worry the challenge is now
    back live on the site and maybe someone who is less of a chicken will take it up next time!"
    @message.user = user
    @message.chatroom = chatroom
    @message.save
    return @message
  end

  def host_left_message(message, user, chatroom, challenge)
    @message = message
    @message.content = "Hi #{challenge.guest.username}, #{user.username} just left the #{challenge.game} challenge... Chicken! Don't worry there are plenty of
    challenges on the site for you to try!"
    @message.user = user
    @message.chatroom = chatroom
    @message.save
    return message
  end

  def broadcast_message
    ActionCable.server.broadcast("chatroom_#{self.chatroom.id}", {
      message_partial: ApplicationController.renderer.render(partial: "messages/message", locals: { message: self, user_is_messages_author: false }),
      current_user_id: user.id
    })
  end

  def from?(some_user)
    user == some_user
  end
end
