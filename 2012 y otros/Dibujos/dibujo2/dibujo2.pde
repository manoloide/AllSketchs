ArrayList dibujadores;

void setup() {
  size(400, 800);
  background(255);
  frameRate(60);
  colorMode(HSB,360,255,255);
  smooth();
  dibujadores = new ArrayList();
  for (int i = 0; i < 100; i++) {
    dibujadores.add(new Dibujador(random(width), 0));
  }
}

void draw() {
  Dibujador aux;
  for (int i = 0; i < dibujadores.size(); i++) {
    aux = (Dibujador) dibujadores.get(i);
    aux.act();
  }
}

