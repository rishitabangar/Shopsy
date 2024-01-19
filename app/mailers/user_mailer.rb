class UserMailer < ApplicationMailer
  default from: 'ribangar@bestpeers.in'

  def welcome_email(user)
    @user = user
    mail to: @user.email, subject: "Welcome Email!!"
  end

  def order_email(user,items)
    @items = items
    @user = user
    mail to: @user.email, subject: "Order confirmed Email!!"
  end
end
