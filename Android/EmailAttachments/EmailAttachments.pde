import android.content.Intent;
import android.content.Context;
import android.net.Uri;
import java.io.File;

/*
EMAIL ATTACHMENTS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Unfortunately, not working at the moment... :(
 
 */

String subject = "Test from your Android device!";
String emailBody = "This is an email, sent from your Android device. Congrats!";
String filename = "attachmentTest.txt";

Intent email;
PFont font;

void setup() {
  // setup and font creation
  smooth();
  noStroke();
  font = createFont("SansSerif", 60);
  textFont(font);
  textAlign(CENTER, CENTER);

  // create text file of random characters to send  
  for (int line=0; line<file.length; line++) {
    String chars = "";
    for (int c=0; c<30; c++) {
      chars += char(int(random(48, 96)));
    }
    file[line] = chars;
  }
  saveStrings(filename, file);

  // send the email!
  sendEmail();
}

void draw() {
  background(0, 50, 50);
  fill(255);
  text(" [ email sent with attachment! ]", width/2, height/2);
}

void sendEmail() {
  try {
    // create email message
    email = new Intent(Intent.ACTION_SEND);
    email.setType("text/plain");
    email.putExtra(Intent.EXTRA_SUBJECT, subject);
    email.putExtra(Intent.EXTRA_TEXT, emailBody);

    // http://stackoverflow.com/a/1279574/1167783
    // http://stackoverflow.com/a/8295155/1167783  
    String attachFile = "file://" + getFilesDir().getAbsolutePath() + "/" + filename;
    //email.putExtra(Intent.EXTRA_STREAM, Uri.parse(attachFile));
    email.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(new File(getFilesDir(), filename)));    
    println(attachFile); 

    // send!
    startActivity(Intent.createChooser(email, "Send email..."));
  }
  catch (android.content.ActivityNotFoundException ex) {
    println("No email client installed, email failed... :(");
  }
}
