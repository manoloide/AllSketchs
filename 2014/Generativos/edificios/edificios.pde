color paleta[];
float angulos[];
void setup() {
  size(800, 600);
  smooth(8);
  paleta = new color[5];
  paleta[0] = color(#F1ECDF);
  paleta[1] = color(#D4C9AD);
  paleta[2] = color(#C7BA99);
  paleta[3] = color(#000000);
  paleta[4] = color(#F58723);
  paleta[0] = color(#4E4D4A);
  paleta[1] = color(#353432);
  paleta[2] = color(#94BA65);
  paleta[3] = color(#2790B0);
  paleta[4] = color(#2B4E72);
  angulos = new float[3];
  for (int i = 0; i < angulos.length; i++) {
    angulos[i] = random(TWO_PI);
  }
  angulos[0] = angulos[1] + PI/2;
}
void draw() {
  if (frameCount == 10)
    generar();
}

void keyPressed() {
  if (key == 's') {
    saveFrame("####");
    return;
  }
  generar();
}
void generar() {
  float w = random(100, 300);
  float h = random(100, 300);
  float x = random(width);
  float y = random(height);
  translate(x, y);
  rotate(angulos[int(random(3))]);
  rectangulo(-w/2, -h/2, w, h);
  resetMatrix();
}

void rectangulo(float x, float y, float w, float h) {
  //rect(x, y, w, h);
  stroke(0,120);
  int cant = int(w*h)/10;
  for (int i = 0; i < cant; i++) {
    float ww = random(10, 40);
    float hh = random(10, 40);
    float xx = random(w-ww);
    float yy = random(h-hh);
    fill(paleta[int(random(5))],80);
    rect(x+xx, y+yy, ww, hh);
  }
}
