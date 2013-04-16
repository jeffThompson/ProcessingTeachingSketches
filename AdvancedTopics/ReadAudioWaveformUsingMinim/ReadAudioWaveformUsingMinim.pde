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
  
  // open audio file
  minim = new Minim(this);
  song = minim.loadSample(filename);

  // load samples into an array (this just gets left channel - load
  // separately and average, or just assume they are close enough
  samples = song.getChannel(BufferedAudio.LEFT);
  
  // print the first 10,000 samples so we can see what they look like
  for (int i=0; i<10000; i++) {
    print(samples[i] + "  ");
  }
}

