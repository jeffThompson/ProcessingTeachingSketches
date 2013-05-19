import android.media.*;                               // imports required for audio playback
import android.content.res.*;
import android.media.AudioTrack;
import android.media.audiofx.EnvironmentalReverb;

/*
AUDIO EFFECTS
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Cool audio effects!
 
 Required permission:
 MODIFY_AUDIO_SETTINGS
 */

// sound effect to load (must be in data folder)
String audioFilename = "pop.mp3";  // via: http://soundjax.com/pop-3.html

// reverb effect settings
int decayTime = 200000;            // 10 to 20k
short density = 1000;              // 0 to 1k
short diffusion = 0;               // 0 to 1k
short roomLevel = 0;               // -9k to 0
short reverbLevel = 2000;          // -9k to 2k
short reflectionsDelay = 0;        // 0 to 300
short reflectionsLevel = 1000;     // -9k to 1k
short reverbDelay = 0;             // 0 to 100

MediaPlayer rec;              // audio recording object
EnvironmentalReverb reverb;   // reverb effect
PFont font;

void setup() {

  // basic setup
  orientation(LANDSCAPE);
  font = createFont("SansSerif", height/4);
  textFont(font, height/4);
  textAlign(CENTER,CENTER);
  noStroke();

  try {
    // load audio file for playback
    rec = new MediaPlayer();
    AssetManager assets = this.getAssets();
    AssetFileDescriptor fd = assets.openFd(audioFilename);
    rec.setDataSource(fd.getFileDescriptor(), fd.getStartOffset(), fd.getLength());

    // add reverb settings
    reverb = new EnvironmentalReverb(0, 0);
    reverb.setDecayTime(decayTime);
    reverb.setDensity(density);
    reverb.setDiffusion(diffusion);
    reverb.setReverbLevel(reverbLevel);
    reverb.setRoomLevel(roomLevel);
    reverb.setReflectionsDelay(reflectionsDelay);
    reverb.setReflectionsLevel(reflectionsLevel);
    reverb.setReverbDelay(reverbDelay);
    reverb.setEnabled(true);

    // attach reverb to main audio out
    rec.attachAuxEffect(reverb.getId());
    rec.setAuxEffectSendLevel(1.0f);      // level is set to 0 by default
    rec.prepare();

    println(reverb.toString());
  }
  catch (IOException ioe) {
    println("Error: couldn't find your audio file - maybe it's not in the sketch's data folder?");
  }
}

void draw() {
  fill(255, 150, 0);
  rect(0, 0, width/2, height);
  fill(255);
  text("DRY", width/4, height/2);

  fill(0, 150, 255);
  rect(width/2, 0, width/2, height);
  fill(255);
  text("WET", width-width/4, height/2);
}

void mouseDragged() {
  if (!rec.isPlaying()) {
    if (mouseX < width/2) {
      rec.setAuxEffectSendLevel(0.0f);    // just dry recording
      rec.start();
    }
    else {
      rec.setAuxEffectSendLevel(1.0f);    // play with reverb
      rec.start();
    }
  }
}

