class Sonido {
  AudioPlayer s_musica;
  AudioSample s_absorcion, s_draco, s_muerte; 
  Sonido() {
    s_musica = minim.loadFile("Sonido/musica.mp3");
    s_absorcion = minim.loadSample("Sonido/absorcion.wav");
    s_draco = minim.loadSample("Sonido/draco.wav");
    s_muerte = minim.loadSample("Sonido/muerte.wav");
    s_musica.loop();
  }
  void act(){
    s_musica.setGain((musica.val-1)*48);
    s_absorcion.setGain((vfx.val-1)*48);
    s_draco.setGain((vfx.val-1)*48);
    s_muerte.setGain((vfx.val-1)*48);
    /*
    if(s_musica.gain() <= -50.) s_musica.mute();
    println(s_musica.gain());
    */
  }
  void close() {
    s_musica.close();
    s_absorcion.close();
  }
}
