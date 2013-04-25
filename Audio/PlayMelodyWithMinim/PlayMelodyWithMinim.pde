import ddf.minim.*;
import ddf.minim.signals.*;

/*
PLAY MELODY WITH MINIM
Jeff Thompson | 2013 | www.jeffreythompson.org

Uses timing to play notes of set durations using the Minim library.

*/

int duration = 500;    // duration of notes in ms
int numNotes = 5;      // # of notes to play

boolean playing = false;    // flag for when melody has been triggered
int whichNote = 0;          // keeps track of which note is playing
long prevNoteTime = 0;      // time the last note was triggered
Minim minim;                // Minim-related objects
AudioOutput out;
SineWave sine;

void setup() {
  minim = new Minim(this);                          // basic audio setup
  out = minim.getLineOut(Minim.STEREO, 512);
  sine = new SineWave(330, 0.0, out.sampleRate());  // start at 0 volume
  out.addSignal(sine);                              // must add sinewave to output!
}

void draw() {
  if (playing) {    // if triggered...
    playNotes();    // ... play!
  }
}

void keyPressed() {
  if (key == 32 && !playing) {  // so long as we're not already playing
    playing = true;             // turn playing on
    sine.setAmp(1);             // turn on volume to 1
    whichNote = 0;              // reset note count
  }
}

void playNotes() {
  if (millis() > prevNoteTime + duration) {    // if enough time has passed for a new note
    println("Playing note: " + whichNote);
    
    sine.setFreq((whichNote * 50) + 200);                  // create frequency (could also load from an array)
    float pan = map(whichNote, 1, numNotes, -1.0, 1.0);    // pan based on position in melody
    sine.setPan(pan);

    if (whichNote == numNotes) {               // done? set volume to 0 and stop playing
      sine.setAmp(0);
      playing = false;
    }
    else {
      whichNote++;                             // otherwise, go to the next note
    }
    prevNoteTime = millis();                   // note start of a new note at current time
  }
}

