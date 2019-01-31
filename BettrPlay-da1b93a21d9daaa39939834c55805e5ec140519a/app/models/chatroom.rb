class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :receiver, class_name: 'User'
  belongs_to :sender, class_name: 'User'
  validates_uniqueness_of :sender_id, :scope => :receiver_id
  scope :between, ->(sender_id, receiver_id) do
    where("(sender_id = ? and receiver_id = ?) or (sender_id = ? and receiver_id = ?)", sender_id, receiver_id, receiver_id, sender_id)
  end

  def users_in_challenge?
    Challenge.where(:host_id == :sender_id, :guest_id == :receiver_id).exists? || Challenge.where(:host_id == :receiver_id, :guest_id == :sender_id).exists?
  end

  def other_person(current_user, chat)
    if chat.sender_id == current_user.id
      # return User.where(chat.receiver_id == :id)
      return User.all.select { |u| u.id == chat.receiver_id }[0]
    else
      # return User.where(chat.sender_id == :id)
      return User.all.select { |u| u.id == chat.sender_id }[0]
    end
  end

  def find_chatroom(chatroom, current_user, host)
    @chatroom = chatroom
    if Chatroom.between(current_user.id, host.id).present?
      @chatroom = Chatroom.between(current_user.id, host.id).first
    else
      @chatroom = Chatroom.create!(sender: current_user, receiver: host)
    end
  end

  def find_chatroom_for_destroy(chatroom, current_user, guest)
    @chatroom = chatroom
    if Chatroom.between(current_user.id, guest.id).present?
      @chatroom = Chatroom.between(current_user.id, guest.id).first
    else
      @chatroom = Chatroom.create!(sender: current_user, receiver: guest)
    end
  end
end
