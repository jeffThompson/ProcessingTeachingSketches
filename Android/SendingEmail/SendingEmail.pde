import android.content.Intent;    // imports required for email

/*
SENDING EMAIL
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Note email address is not specified here; this allows the user
 to add it themselves! The email process could easily be mapped
 to a button or other event for a more interactive process.
 
 Email attachments are possible, but I can't quite get them to
 work at the moment: see the EmailAttachments example for a start.
 
 Required permissions:
 1. INTERNET
 
 CHALLENGE:
 1. Create a random email generator that creates algorithmic text!
 */

String subject = "Test from your Android device!";
String emailBody = "This is an email, sent from your Android device. Congrats!";

Intent email;
PFont font;

void setup() {
  // setup and font creation
  smooth();
  noStroke();
  font = createFont("SansSerif", 60);
  textFont(font);
  textAlign(CENTER, CENTER);

  // send an email!
  sendEmail();
}

void draw() {
  background(50, 75, 200);
  fill(255);
  text("[ email sent! ]", width/2, height/2);
}

void sendEmail() {
  try {
    // create email message
    email = new Intent(Intent.ACTION_SEND);
    email.setType("text/plain");
    email.putExtra(Intent.EXTRA_SUBJECT, subject);
    email.putExtra(Intent.EXTRA_TEXT, emailBody);

    // send!
    startActivity(Intent.createChooser(email, "Send email..."));
  }
  catch (android.content.ActivityNotFoundException ex) {
    println("No email client installed, email failed... :(");
  }
}

