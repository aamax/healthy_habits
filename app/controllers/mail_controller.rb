class MailController < ApplicationController
  def new
    # used to create ezine emails to send out

  end

  def create
    # send the ezine email

  end

  def deliver_mail
    @toaddress = params[:mailmessage][:toaddress]
    @subject = params[:mailmessage][:subject]
    @fromaddress = 'healthyhabitsutah@gmail.com'

    @message = "FROM: http://www.healthyhabitsutah.com (healthyhabitsutah@gmail.com)\n\n#{params[:mailmessage][:message]}"

    HostMailer.send_single_email(@toaddress, @fromaddress,
                                 @subject, @message).deliver

    flash[:success] = "Email sent..."
    redirect_to(root_path)
  end

end
