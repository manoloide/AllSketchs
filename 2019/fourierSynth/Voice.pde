class Voice implements Instrument {
  
  Oscil sineOsc;
  ADSR  adsr;
  
  Voice( float frequency, float amplitude ){    
    sineOsc = new Oscil( frequency, amplitude, Waves.TRIANGLE );
    adsr = new ADSR( 0.5, 0.01, 0.05, 0.5, 0.5 );
    sineOsc.patch( adsr );
  }
  
  void noteOn( float dur ){
    adsr.noteOn();
    adsr.patch( out );
   }
  
  void noteOff(){
    adsr.unpatchAfterRelease( out );
    adsr.noteOff();
  }
}
