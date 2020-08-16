import ddf.minim.*;
import ddf.minim.ugens.*;

/*
  añadir radio
 crear oscilador
 crear 6 osiladores
 cambiar la frecuencia de cada osilador
 añadir pianoroll
 dibujar waave y usar las transformada
 
 
 añadir delay
 añadir rever
 añadir chorus
 */


Minim minim;

AudioInput in;
AudioRecorder recorder;
boolean recorded;
AudioOutput out;

Voice voice;

Oscil wave;
ADSR  adsr;
Midi2Hz midi;

float vol;
int octave = 0;

boolean presseds[];


void setup() {
  size(720, 430, P2D);
  pixelDensity(2);
  smooth(4);

  minim = new Minim(this);
  out   = minim.getLineOut();

  //recorder = minim.createRecorder(out, "recs/"+getTimestamp()+".wav");
  recorder = minim.createRecorder(out, "rec.wav");

  wave = new Oscil( 300, 0.6f, Waves.SINE );
  adsr = new ADSR( 0.5, 0.01, 0.05, 0.5, 0.5 );
  midi = new Midi2Hz( 50 );

  midi.patch( wave.frequency );

  wave.patch( adsr );
  wave.setAmplitude(0.4f);
  //wave.patch( out );

  presseds = new boolean[50];
}


void draw() {

  background(26);//#141315);

  int colors[] = {#D882DD, #FA4A3A, #75FCD5, #A2B1FF};

  for (int i = 0; i < 4; i++) {

    int col = colors[i];

    drawAudio(out, 20+width*0.25*i, 20, width*0.25-40, height*0.2, col);

    drawAudio(out, 20+width*0.25*i, 20+height*0.5, width*0.25-40, height*0.2, col);
  }

  int total = 50;
  float ss = width/total;
  for (int i = 0; i < total; i++) {
    if (presseds[i]) {
      noFill();
      stroke(colors[i%colors.length]);
    } else {
      noStroke();
      fill(colors[i%colors.length]);
    }
    rect(2+i*ss, height-48, ss-4, 48-4);
  }


  if (recorded) {
    if (frameCount%60 < 30) {
      fill(#FF62E3);
      ellipse(20, 20, 16, 16);
    }
  }
}

void drawAudio(AudioOutput out, float x, float y, float w, float h, int col) {


  stroke(255, 80);
  noFill();
  line(x, y+h*0.5, x+w, y+h*0.5);
  rect(x-4, y-4, w+8, h+8);
  stroke(255, 120);
  fill(0);
  rect(x, y, w, h);
  stroke(col, 240);

  for (int i = 1; i < out.bufferSize() - 1; i++) {
    float x1 = x + map( i, 0, out.bufferSize(), 0, w );
    float x2 = x + map( i+1, 0, out.bufferSize(), 0, w );

    {
      float y1 = y + (out.left.get(i+0)) * h * 0.25 + h*0.25;
      float y2 = y + (out.left.get(i+1)) * h * 0.25 + h*0.25;

      line( x1, y1, x2, y2);
    }


    {
      float y1 = y + (out.right.get(i+0)) * h * 0.25 + h*0.75;
      float y2 = y + (out.right.get(i+1)) * h * 0.25 + h*0.75;

      line( x1, y1, x2, y2);
    }
  }
}

void exit() {
  println("adios");


  if (recorded) {
    recorder.endRecord();
    recorded = false;

    recorder.save();
  }


  super.exit();
}

void keyPressed() {

  int note = -1;

  if ( key == 'a' ) note = 50;
  if ( key == 's' ) note = 52;
  if ( key == 'd' ) note = 54;
  if ( key == 'f' ) note = 55;
  if ( key == 'g' ) note = 57;
  if ( key == 'h' ) note = 59;
  if ( key == 'j' ) note = 61;
  if ( key == 'k' ) note = 62;
  if ( key == 'l' ) note = 64;
  if ( key == ';' ) note = 66;
  if ( key == '\'') note = 67;


  if ( key == 'z' ) octave--;
  if ( key == 'x' ) octave++;


  if (note != -1) {
    //

    int actual = note+octave*12;

    midi.setMidiNoteIn(actual);
    wave.setPhase(0);

    presseds[actual-24] = true;

    // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    adsr.patch( out );
  }


  if (key == 'r' ) {

    recorded = !recorded;

    if ( recorder.isRecording() ) {
      recorder.endRecord();
      recorded = false;
      recorder.save();
    } else {
      recorder.beginRecord();
    }
  }
}

void keyReleased() {

  // tell the ADSR to unpatch after the release is finished
  adsr.unpatchAfterRelease( out );
  // call the noteOff 
  adsr.noteOff();
}

String getTimestamp() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  return timestamp;
}
