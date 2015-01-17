class UserMailer < ActionMailer::Base
  default from: "Document Tracker <documentracker@gmail.com>"

  def welcome_email(account, password)
    @account = account
    @password = password
    mail to: @account.email, subject: "Welcome to Document Tracker"
  end
end
