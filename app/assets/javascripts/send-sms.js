function sendTextMessage() {

  var phoneNumber = $("#phone_number").val();
  var postPhoneNumber = $("#post_phone_number").val();
  var messageBody = $("#message").val();

  var accountSid = 'AC1894bcf283cbedd6f0966fdef9114dd6';
  var authToken = 'e7598fae26daedd3948c1a6de49ced1b';

  var client = require('twilio')(accountSid, authToken);

  client.messages.create({
    to: phoneNumber,
    from: postPhoneNumber,
    body: message,
  }, function(err, message) {
    console.log(message.sid);
  });

}
