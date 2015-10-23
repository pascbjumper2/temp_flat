class ModelMailer < ActionMailer::Base
  default from: "postmaster@flatjack.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #


  # def new_record_notification
  #   @greeting = "Hi"
  #
  #   mail to: "to@example.org"
  # end


  def new_record_notification(record)
    @record = record
    #mail to: @record.email, subject: "Success! You did it."
    mail to: @record.email, subject: "Flat-Jack - Order Received" #, :bcc => ["Info@flatjack.com", "Copy of order placed at flatjack.com <" + @record.email + ">"]
  end

end
