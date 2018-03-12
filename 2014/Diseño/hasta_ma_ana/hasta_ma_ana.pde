PImage fondo;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  textFont(loadFont("bebas80.vlw"));
  fondo = crearDegrade(width, height, #0080E5, #0A93FF);
}
void draw() {
  background(fondo);
  pushMatrix();
  translate(302, 403, 445);
  rotateX(PI*0.327);
  rotateY(PI*0.004);
  rotateZ(PI*-0.103);
  noStroke();
  fill(255);
  text("Hasta\nLuego", 0, 0);
  popMatrix();
  translate(302, 420, 445);
  rotateX(PI*0.327);
  rotateY(PI*0.004);
  rotateZ(PI*-0.103);
  fill(0, 40);
  text("Hasta\nLuego", 0, 0);
}

PImage crearDegrade(int w, int h, color c1, color c2) {
  PImage aux = createImage(w, h, RGB);
  for (int j = 0; j < h; j++) {
    color c = lerpColor(c1, c2, map(j, 0, h, 0, 1));
    for (int i = 0; i < w; i++) {
      color ac = c;
      if ((i+j)%2 == 0) {
        //ac = lerpColor(c, color(0), 0.08);
      }
      aux.set(i, j, ac);
    }
  }
  return aux;
}
