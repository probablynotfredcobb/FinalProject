function sendTextMessage() {

  var phoneNumber = $("#phone_number").val();
  var postPhoneNumber = $("#post_phone_number").val();
  var messageBody = $("#message").val();

  // # account details 

  var client = require('twilio')(accountSid, authToken);

  client.messages.create({
    to: phoneNumber,
    from: postPhoneNumber,
    body: message,
  }, function(err, message) {
    console.log(message.sid);
  });

}
;
