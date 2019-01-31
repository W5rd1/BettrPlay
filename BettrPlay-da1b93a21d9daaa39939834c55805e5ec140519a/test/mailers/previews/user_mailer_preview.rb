# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/confirm
  def confirm
    UserMailer.confirm
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    UserMailer.welcome
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/guest_join
  def guest_join
    UserMailer.guest_join
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/deposit
  def deposit
    UserMailer.deposit
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/withdraw
  def withdraw
    UserMailer.withdraw
  end

end
