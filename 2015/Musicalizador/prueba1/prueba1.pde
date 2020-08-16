import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

int tonalidad, nota, acorde;
int escalaMayor[] = {0, 2, 4, 5, 7, 9, 11};
int parteA[] = {0, 3, 4, 1};
PFont helve;
PImage fondo;
String acordes[] = {"", "m", "m", "", "", "m", "d"};
String notas[] = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"};
Timer timer;

void setup() {

  size(800, 600);
  helve = createFont("Helvetica Neue Bold", 190, true);
  fondo = createFondo();
  timer = new Timer();
  image(fondo, 0, 0);
  textFont(helve);

  minim = new Minim(this);
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
}

void draw() {

  if(frameCount%10 == 0) frame.setTitle("FPS: "+frameRate);
  
  timer.update();
  if(timer.changeCompas){
    //acorde = int(random(escalaMayor.length));
    acorde = parteA[timer.compas%4];
    //nota = (tonalidad+escalaMayor[int(random(escalaMayor.length))])%notas.length;
    float n1 = Frequency.ofPitch(notas[(tonalidad+escalaMayor[(acorde+0)%7])%12]).asHz();
    float n2 = Frequency.ofPitch(notas[(tonalidad+escalaMayor[(acorde+2)%7])%12]).asHz();
    float n3 = Frequency.ofPitch(notas[(tonalidad+escalaMayor[(acorde+4)%7])%12]).asHz();
    out.playNote( 0.0, 3.0, new SyntAtmosInstrument(n1));
    out.playNote( 0.0, 3.0, new SyntAtmosInstrument(n2));
    out.playNote( 0.0, 3.0, new SyntAtmosInstrument(n3));
  } 
  if(timer.changePulse){
    if(4-random(timer.pulse) > 2){
      nota = (tonalidad+escalaMayor[int(random(escalaMayor.length))])%notas.length;
      out.playNote( 0.0, 0.5, new SineInstrument(Frequency.ofPitch(notas[nota]).asHz()*2));
    }
    if(timer.pulse%2 == 0){
     float n1 = Frequency.ofPitch(notas[(tonalidad+escalaMayor[(acorde+0)%7])%12]).asHz()*0.25;
     //out.playNote( 0.0, 0.8, new BassInstrument(n1));
   }else{
    float n1 = Frequency.ofPitch(notas[(tonalidad+escalaMayor[(acorde+5)%7])%12]).asHz()*0.25;
    //out.playNote( 0.0, 0.8, new BassInstrument(n1));
  }
} 


  //dibujar fondo
  image(fondo, 0, 0);
  stroke(255, 80);
  strokeWeight(2);
  fill(255, 220);
  textAlign(LEFT, TOP);
  textSize(80);
  for(int i = 0; i < parteA.length; i++){
    if(timer.compas%4 == i){
      fill(255, 220);
    }else{
      fill(220, 100);
    }
    text(notas[(tonalidad+escalaMayor[parteA[i]])%12]+acordes[parteA[i]], 120+120*i, 120);
  }
  textSize(90/4);
  //text(notas[nota], 320, 120);
  for(int i = 0; i < notas.length; i++){
    textAlign(CENTER, TOP);
    if(contains(escalaMayor, (i-tonalidad+12)%12)){
      fill(255, 220);
    }else{
      fill(220, 100);
    }
    text(notas[i], 132+28*i, 208);
  }
}

void keyPressed(){

  if(key == 'g') generar();

}

void generar(){

  tonalidad = int(random(notas.length));
  for(int i = 0; i < 4; i++){
    parteA[i] = int(random(7));
  }
}

PImage createFondo(){
  PGraphics aux = createGraphics(width, height);
  aux.beginDraw();
  for(int j = 0; j < height; j++){
    color c1 = lerpColor(color(#6BBAB7), color(#A9D7B8), j*1.0/height);
    color c2 = lerpColor(color(#6BBAB7), color(#F57A7A), j*1.0/height);
    for(int i = 0; i < width; i++){
      color col = lerpColor(c1, c2, i*1.0/width);
      col = lerpColor(col, color(50), 0.6);;
      aux.set(i, j, col);
    }
  }
  aux.strokeWeight(2);
  aux.stroke(250, 20);
  for(int i = 0; i < width+height; i+= 10){
    aux.line(-2, i, i, -2);
  }
  aux.endDraw();
  return aux.get();
}

boolean contains(int[] array, int key) {
  for (final int i : array) {
    if (i == key) {
      return true;
    }
  }
  return false;
}

class Timer{

  boolean changePulse, changeCompas;
  int bpm, realTime; 
  int antPulse, antCompas;
  int pulse, compas;

  Timer(){

    bpm = 190; 
    realTime = 60000/bpm;

  }

  void update(){


    changeCompas = changePulse = false;
    antPulse = pulse;
    pulse = (int(millis()/realTime))%4;
    if(antPulse != pulse) changePulse = true;
    antCompas = compas;
    compas = int(millis()/(realTime*4));
    if(antCompas != compas) changeCompas = true;

  }

  void setBPM(int nbpm){
    bpm = nbpm;
    realTime = 60000/bpm;

  }

}

class SineInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    // start the amplitude envelope
    ampEnv.activate( duration, 0.08f, 0 );
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}

class BassInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  BassInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, Waves.SAW);
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    // start the amplitude envelope
    ampEnv.activate( duration, 0.02f, 0 );
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}

class SyntAtmosInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  SyntAtmosInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, Waves.SAW );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    // start the amplitude envelope
    ampEnv.activate( 2, 0.040f, 0 );
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}
