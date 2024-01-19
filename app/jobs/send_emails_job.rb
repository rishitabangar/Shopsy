class SendEmailsJob < ApplicationJob
  queue_as :default  

  def perform(user)
    UserMailer.welcome_email(user).deliver
  end

  # def confirmedorder(user)
  #   UserMailer.orderemail(user).deliver
  # end

end
