class TwilioApi
  SID = ENV.fetch('TWILIO_ACCOUNT_SID')
  TOKEN = ENV.fetch('TWILIO_AUTH_TOKEN')
  CLIENT = Twilio::REST::Client.new(SID, TOKEN)

  def self.twilio_number
    # A Twilio number you control - choose one from:
    # https://www.twilio.com/user/account/phone-numbers/incoming
    # Specify in E.164 format, e.g. "+16519998877"
    ENV['TWILIO_NUMBER']
  end

  def self.send(opts = {})
    CLIENT.account.messages.create(
      from:  opts[:from],
      to:    opts[:to],
      body:  opts[:body]
    )
  end
end
