
require 'twilio-ruby'

#Account info

@client = Twilio::REST::Client.new account_sid, auth_token




@client.account.messages.create({
  :from => '+13016846938',
  :to => @post_number,
  :body => "Hi this person is interested in your post #{@post_title}. Contact them at #{@phone_number}. #{@message}"
  # ,
  # :media_url => 'https://c1.staticflickr.com/3/2899/14341091933_1e92e62d12_b.jpg',
})
