ArrayList cubos;
PShape s;

float p1, p2;
void setup() {
  size(600, 600);
  frameRate(30);
  smooth();
  noStroke();

  cubos = new ArrayList();
  for (int i = 0; i < 20; i++) {
    cubos.add(new Cubo(random(width), random(height)));
  }
  s = loadShape("c.svg");
  p1 = int(random(height));
  p2 = int(random(height));
}
void draw() {
  p1 += random(41) - 20;
  p2 += random(41) - 20;
  pushMatrix();
  translate(random(2)-1, random(2)-1);
  shape(s, 0, 0, width, height);
  for (int i = 0; i < cubos.size(); i++) {
    Cubo aux = (Cubo) cubos.get(i);
    aux.act();
  }
  cuadricula();
  ruido();
  lineas(p1);
  lineas(p1);
  lineas(p1);
  lineas(p2);
  lineas(p2);
  lineas(p2);
  lineas(p2);
  popMatrix();
  for (int i = 1; i < 20;i++){
    desfazar(int(random(height)),int(random(5)));
  }
}
void cuadricula() {
  noStroke();
  int vx = width/10;
  int vy = height/10;
  for (int j = 0; j < vy; j++) {
    for (int i = 0; i < vx; i++) {
      fill(random(256), random(30));
      rect(i*10, j*10, 10, 10);
    }
  }
}

void ruido() {
  for (int i = 0; i < 1000; i++) {
    int x = int(random(width));
    int y = int(random(height));
    color c = color(random(256));
    set(x, y, c);
  }
}
void lineas(float p) {
  if (random(6) > 5) {
    color c = color(50 + random(156));
    stroke(c);
    p += random(41) - 20;
    line(0, p, width, p);
  }
}

void desfazar(int y, int dez) {
  //y = int(random(width));
  //int dez = int(random(10));
  loadPixels ();
  color linea[] = new color[width];
  for (int i = width*y; i < width*(y+1); i++) {
    linea[i-width*y] = pixels[i];
  }
  for(int i = 0; i < width; i++){
    pixels[width*y+i] = linea[(width+i+dez)%width];
  }
  updatePixels ();
}

