import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

Midi2Hz midi;
SineInstrument sine;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();


  midi = new Midi2Hz( 50 );
}

void draw() {
  background(0);
  stroke(255);

  // draw the waveforms
  for (int i = 0; i < out.bufferSize()-1; i++) {
    line( i, 50+out.left.get(i)*50, i+1, 50+out.left.get(i+1)*50 );
    line( i, 150+out.right.get(i)*50, i+1, 150 +out.right.get(i+1)*50 );
  }
}

void keyPressed() {
  
  float freq = 10;
  
  if ( key == 'a' ) midi.setMidiNoteIn( 50 );
  if ( key == 's' ) midi.setMidiNoteIn( 52 );
  if ( key == 'd' ) midi.setMidiNoteIn( 54 );
  if ( key == 'f' ) midi.setMidiNoteIn( 55 );
  if ( key == 'g' ) midi.setMidiNoteIn( 57 );
  if ( key == 'h' ) midi.setMidiNoteIn( 59 );
  if ( key == 'j' ) midi.setMidiNoteIn( 61 );
  if ( key == 'k' ) midi.setMidiNoteIn( 62 );
  if ( key == 'l' ) midi.setMidiNoteIn( 64 );
  if ( key == ';' ) midi.setMidiNoteIn( 66 );
  if ( key == '\'') midi.setMidiNoteIn( 67 );
  

  sine = new SineInstrument(freq);
  sine.noteOn(1);
}
