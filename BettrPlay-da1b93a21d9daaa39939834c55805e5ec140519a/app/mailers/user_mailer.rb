class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm(user)
    @user = user

    mail(to: @user.email, subject: 'Confirm your email for BettrPlay')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user

    mail(to: @user.email, subject: 'Welcome to BettrPlay')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.guest_join.subject
  #
  def guest_join(user)
    @user = user

    mail(to: @user.email, subject: 'Your challenge is ready!')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.deposit.subject
  #
  def deposit(user)
    @user = user

    mail(to: @user.email, subject: 'Deposit confirmation')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.withdraw.subject
  #
  def withdraw(user)
    @user = user

    mail(to: @user.email, subject: 'Withdrawel confirmation')
  end
end
