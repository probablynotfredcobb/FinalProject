class MessagesController < ApplicationController
  def create
    MessageSender.send_message(message)
    redirect_to root_url,
      success: 'Thank you! The poster should be contacting you shortly.'
  rescue Twilio::REST::RequestError => error
    p error.message
    redirect_to root_url,
      error: 'Oops! There was an error. Please try again.'
  end

  private

  def message
    "New lead received for #{params[:house_title]}. " \
    "Call #{params[:name]} at #{params[:phone]}. " \
    "Message: #{params[:message]}"
  end
end
