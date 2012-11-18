/*
EXPORT TO FFMPEG
 Jeff Thompson
 January 2012, updated October 2012
 
 UPDATE: if the sketch breaks with a Java IOException error, you may need to specify the path to your ffmpeg install; in my
 case, this is "/usr/local/bin/", making the command "/usr/local/bin/ffmpeg filename.mov etc..." instead of just "ffmpeg".
 The "-c:v" option to specify the codec is also updated to "-vcodec" for video and "-acodec" for audio.
 
 Exports still images to a video using ffmpeg, an open-source video utility that runs on the command line.  Once you have
 ffmpeg installed, creating vidoes will be fast and you will have LOTS of control over the parameters, which is especially
 helpful for hard-edged graphics and similar images.
 
 Details listed in the encoding section below; codec is likely the most important factor, so setting that manually will be 
 very helpful!  The "png" codec is great, but will create rather large files; mjpeg (MotionJPEG) also works well for graphics
 and hard edges (pixellated images, etc); H.264 is all-around good for photgraphic images
 
 Installing ffmpeg on Mac Snow Leopard (based on a tutorial by Stephen Jungels):
 http://www.jeffreythompson.org/blog/2012/01/07/installing-ffmpeg-and-lame-on-mac-snow-leopard
 
 Video export using ffmpeg inspired by:
 http://linuxers.org/tutorial/how-extract-images-video-using-ffmpeg
 
 www.jeffreythompson.org
 */

String ffmpegInstall = "/usr/local/bin/";  // you may need to specify the location that ffmpeg is installed**
String exportFilename = "test.mov";        // MUST INCLUDE EXTENSION (mov, mp4, or see ffmpeg doc for list)
int frameWidth = 320;                      // size for exported video
int frameHeight = 240;
int fps = 24;                              // frames per second for resulting video
int numFrames = 1440;                      // number of frames to create; if loading from a folder, leave zero and set programatically (see code for example)
String codec = "png";                      // set the codec (see note above for suggestions) - VERY IMPORTANT for getting good quality
boolean deleteSourceStills = false;        // delete the stills exported from the source file?

//** to find your install of ffmpeg, in the Finder go to Go > Go to Folder... and type "/usr" - the install is likely somewhere in there

int r, g, b;                                                    // used to generate the image below (can be deleted if creating your own images)
int filenamePadding = (Integer.toString(numFrames)).length();   // adds leading zeroes to the still files (ex: 0001.png)
String commandToRun;                                            // stores the Unix command to be run later (create/delete directory, run ffmpeg)


void setup() {

  // basic setup stuff
  size(frameWidth, frameHeight);
  noStroke();
  rectMode(CENTER);

  // create a folder for the exported stills (will be deleted later, along with the stills themselves)
  println("Creating temporary directory for still images...");
  commandToRun = "mkdir " + "/tmp";
  UnixCommand(commandToRun);

  // alternatively, you can use Java's listFiles() command to test the number of files in a directory
  // if you don't know how many there are (if they are downloaded from a website or pulled from a video, for example)
  // could also be set randomly to make videos of various lengths, etc...
  // numFrames = new File(sketchPath + "/tmp").listFiles().length;

  // process all the files!
  println("\nProcessing " + numFrames + " frames (this may take a while)...");
  for (int currentFrame = 0; currentFrame <= numFrames; currentFrame++) {

    // do something interesting!
    // here we change the background color in a "random walk", though you should do something more exciting...
    if (currentFrame == 0) {
      r = int(random(0,255));
      g = int(random(0,255));
      b = int(random(0,255));
    }
    else {
      int rAdd = int(random(-10,10));
      if (r+rAdd > 0 && r+rAdd < 255) {
        r += rAdd;
      }      
      int gAdd = int(random(-10,10));
      if (g+gAdd > 0 && g+gAdd < 255) {
        g += gAdd;
      }
      int bAdd = int(random(-10,10));
      if (b+bAdd > 0 && b+bAdd < 255) {
        b += bAdd;
      }
    }
    background(r,g,b);
    fill(255);                                    // little white/black squares
    rect(width/3, height/2, width/4, height/4);   // allows us to see the compression of sharp edges
    fill(0);
    rect(width-width/3, height/2, width/4, height/4);

    // only update us on the process every 10 frames
    if (currentFrame % 50 == 0) {
      println("  " + currentFrame + "/" + numFrames);
    }

    // save the result as a still file into the temporary folder
    save("tmp/" + nf(currentFrame, filenamePadding) + ".png");
  }

  // create some video!
  println("\nWriting to video file...");

  /*
   FFMPEG COMMANDS:
   -y means ffmpeg will overwrite any existing video file without asking (otherwise program stalls if a file with the same name exists) 
   -r frameRate sets the input/output framerate
   -i inputFiles (self explanatory!)    
   -vcodec (formerly c:v) sets the output video codec; here we use png since our images are in png format, though other projects have
   had success with mjpeg (motion jpeg) to get a full list of the available codecs for your installation, type "ffmpeg -codec" 
   in the command line
   
   OPTIONAL TO CONSIDER:
   -qscale sets quality (1=highest, 31=lowest)
   -s 1920x1080 will scale the resulting video, though blurring will occur on sharp-edged graphics
   */

  commandToRun = ffmpegInstall + "ffmpeg -y -r " + fps + " -i tmp/%0" + filenamePadding + "d.png -vcodec " + codec + " " + exportFilename;   // command that runs ffmpeg
  UnixCommand(commandToRun);

  // delete source folders as specified at the top and quit
  if (deleteSourceStills) {
    println("Deleting source stills...");
    commandToRun = "rm -r " + sketchPath("") + "/tmp";
    UnixCommand(commandToRun);
  }
  println("\nALL/WELL DONE!");
  exit();
}


// function for running Unix commands (like ffmpeg) inside Processing
void UnixCommand(String commandToRun) {
  File workingDir = new File(sketchPath(""));
  String returnedValues;
  try {
    Process p = Runtime.getRuntime().exec(commandToRun, null, workingDir);
    int i = p.waitFor();
    if (i == 0) {
      BufferedReader stdInput = new BufferedReader(new InputStreamReader(p.getInputStream()));
      while ( (returnedValues = stdInput.readLine ()) != null) {
        // enable this option if you want to get updates when the process succeeds
        // println("  " + returnedValues);
      }
    }
    else {
      BufferedReader stdErr = new BufferedReader(new InputStreamReader(p.getErrorStream()));
      while ( (returnedValues = stdErr.readLine ()) != null) {
        // print information if there is an error or warning (like if a file already exists, etc)
        println("  " + returnedValues);
      }
    }
  }

  // if there is an error, let us know
  catch (Exception e) {
    println("Error, sorry!");  
    println("     " + e);
  }
}

