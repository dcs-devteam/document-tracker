class UserMailer < ActionMailer::Base
  default from: "Document Tracker <documentracker@gmail.com>"

  def welcome_email(user, password)
    @user = user
    @password = password
    mail to: @user.email, subject: "Welcome to Document Tracker"
  end
end
