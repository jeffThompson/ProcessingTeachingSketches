import android.telephony.SmsManager;      // required import for text messaging

/*
SEND TEXT MESSAGE
Jeff Thompson | 2013 | www.jeffreythompson.org

Sending texts using Android is (I think) quite easy! This will not
work on the Nexus or other tablets with only WiFi (no 3G, etc). Not
having an Android phone, this code is not tested - if you do try it
and the code works/doesn't, please email me!

Required permissions:
1. SEND_SMS

See also the Android documentation:
http://developer.android.com/reference/android/telephony/SmsManager.html
*/

String message = "Test: this was sent from my Android device!";   // or ArrayList for multipart messages
String phoneNumber = "1234567890";                                // no dashes, etc

void setup() {
  background(0,25,50);
  smooth();
  noStroke();  
  
  // send a text!
  SmsManager sms = SmsManager.getDefault();
  sms.sendTextMessage(phoneNumber, null, message, null,null);

  // let us know that the message is sent
  PFont font = createFont("SansSerif", 72);
  textFont(font);
  textAlign(CENTER, CENTER);
  text("[ text message sent ]", width/2,height/2);
}
