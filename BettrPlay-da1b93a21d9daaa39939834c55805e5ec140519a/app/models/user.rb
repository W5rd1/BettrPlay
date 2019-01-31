class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # after_create :send_welcome_email
  mount_uploader :photo, PhotoUploader

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable #, :lastseenable, :trackable

  has_many :messages
  has_many :orders
  has_many :hosted_challenges, class_name: 'Challenge', foreign_key: 'host_id'
  has_many :attended_challenges, class_name: 'Challenge', foreign_key: 'guest_id'
  monetize :balance_cents


  # def online?
  #   if current_sign_in_at.present?
  #     (Time.now - current_sign_in_at) < 600
  #   else
  #     false
  #   end
  # end

  private

  # def send_welcome_email
  #   UserMailer.welcome(self).deliver_later
  # end
end
