import promidi.*;

/*
SEND MIDI NOTES (on a Mac)
 Jeff Thompson | 2013 | www.jeffreythompson.org
 
 Sending MIDI out of Processing can make some really cool and
 high quality interactive audio when connected to a program like
 GarageBand.
 
 Requires the ProMIDI library:
 http://creativecomputing.cc/p5libs/promidi
 
 And setting up your MIDI driver (via: http://www.hex705.com/processing-midi-garageband)
 1. Open Audio MIDI Setup (in Applications > Utilities)
 2. Go to Window > Show MIDI Window
 3. Double-click IAC Driver, then check the "Device is online" button
 4. If GarageBand is open, it should alert you that a new MIDI driver is available!
 */

MidiIO midiIO;      // connect in/out
MidiOut midiOut;    // let's us send notes

void setup() {

  // connect as a MIDI device
  midiIO = MidiIO.getInstance(this);
  midiIO.printOutputDevices();
  midiOut = midiIO.getMidiOut(0, 0);       // use output 0, channel 0

    // arguments: note # 0-127, velocity (volume) 0-127, duration in milliseconds
  makeNote(60, 127, 1000);
  makeNote(64, 127, 1000);
  makeNote(70, 127, 1000);
}

void makeNote(int noteNum, int velocity, int duration) {
  Note note = new Note(noteNum, velocity, duration);   // 1000 ms = 1 sec
  midiOut.sendNote(note);                              // send the note!
}

