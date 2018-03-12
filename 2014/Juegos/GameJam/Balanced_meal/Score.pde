class Score {
  int tiempo,itiempo, maxEnergia;
  float energia, avance;
  Score() {
    maxEnergia = 800;
    reset();
  }
  void reset() {
    energia = 0;
    itiempo = frameCount;
  }
  void act() {
    avance = energia/maxEnergia;
    tiempo = frameCount-itiempo;
    if (tiempo > 0 && tiempo%(60*30) == 0) {
      float ang = random(TWO_PI);
      entidades.add(new Draco(width/2+cos(ang)*1000, height/2+sin(ang)+1000));
    }
  }
  float getSegundo() {
    return tiempo/60.;
  }
}
