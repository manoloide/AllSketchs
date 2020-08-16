class SineInstrument implements Instrument {
  
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument(float frequency) {
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  void noteOn( float duration ){
    ampEnv.activate( duration, 0.5f, 0 );
    wave.patch( out );
  }
  
  void noteOff(){
    wave.unpatch( out );
  }
}
