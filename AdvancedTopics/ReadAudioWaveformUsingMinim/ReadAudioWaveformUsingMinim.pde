import ddf.minim.*;

/*
READ AUDIO WAVEFORM USING MINIM
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 The Minim library includes great examples of viewing an audio clip in
 real-time, but what if you want to access all the audio samples directly?
 
 This example opens a short mp3 file and loads all of its samples into
 a float array (values are in a range of -1 to 1).
 
 NOTE: this example requires you install the newest version of the Minim
 library into the Processing app (not your library folder) - for downloads
 and platform-specific instructions, see the Minim site:
 http://code.compartmental.net/tools/minim
 
 */

String filename = "jingle.mp3";    // file to load (mp3, wav, aiff ok)
Minim minim;                       // instance of the Minim library itself
AudioSample song;                  // object that loads audio
float[] samples;                   // array for audio samples as floating point #s (-1 to 1)

void setup() {
  
  size(800,200);
  background(255);
  
  // open audio file
  minim = new Minim(this);
  song = minim.loadSample(filename);

  // load samples into an array (this just gets left channel - load
  // separately and average, or just assume they are close enough
  samples = song.getChannel(BufferedAudio.LEFT);
  
  // draw a small part of the waveform and print the results
  stroke(255,150,0);
  for (int i=0; i<width; i++) {                   // iterate samples
    float sample = abs(samples[i+10000]);         // change range from -1/1 to 0-1, offset into the file (avoids silence at the start)
    sample = map(sample, 0.0, 1.0, 0,height/2);   // map range to window height
    print (sample + "  ");                        // print the result
    line(i, height/2-sample, i,height/2+sample);  // draw the waveform!
  }
}

