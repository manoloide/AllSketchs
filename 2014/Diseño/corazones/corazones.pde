PFont helve, helveliviana;

void setup() {
  size(600, 800);
  helve = createFont("Helvetica Neue Medium", 42, true);
  helveliviana = createFont("Helvetica Neue Bold", 16, true);
  thread("generar");
}
void draw() {
}

void keyPressed() {
  if (key == 's') {
    saveFrame("######");
  } 
  else {
    thread("generar");
  }
}

void drawHeart(float x, float y, float dim) {
  beginShape();
  vertex(x, y-dim*0.25);
  bezierVertex(x, y-dim*0.365, x-dim*0.25, y-dim*0.6, x-dim*0.45, y-dim*0.315);
  bezierVertex(x-dim*0.63, y, x-dim*0.31, y+dim*0.045, x, y+dim*0.50);
  vertex(x, y+dim*0.50);
  bezierVertex(x+dim*0.31, y+dim*0.045, x+dim*0.63, y, x+dim*0.45, y-dim*0.315);
  bezierVertex(x+dim*0.25, y-dim*0.6, x, y-dim*0.365, x, y-dim*0.25);
  endShape();
}


void generar() {
  background(#F7D4D4);
  for (int j = 0; j<height; j++) {
    for (int i = 0; i<width; i++) {
      stroke((random(255)*random(1)), 22);
      point(i, j);
    }
  }
  int cant = 10;
  int tam = 40;
  int bw = 40;
  int dw = (width-bw*2-tam)/(cant-1);
  int bh = 40;
  int dh = dw;
  for (int j = 0; j < cant; j++) {
    for (int i = 0; i < cant; i++) {
      float dim = 40;
      float x = bw+dw*i+dim/2;
      float y = bh+dh*j +(height-width-dh)+dim/2;
      float dx = map(i, 0, cant, 0, 1);
      float dy = map(j, 0, cant, 0, 1);
      fill(255);
      fill(#FFF0F0, 180);
      beginShape();
      vertex(x, y-dim*0.25);
      bezierVertex(x, y-dim*0.365*dx, x-dim*0.25*dx, y-dim*0.6*dy, x-dim*0.45, y-dim*0.315);
      bezierVertex(x-dim*0.63*dx, y, x-dim*0.31*dx, y+dim*0.045*dy, x, y+dim*0.50);
      vertex(x, y+dim*0.50);
      bezierVertex(x+dim*0.31*dx, y+dim*0.045*dy, x+dim*0.63*dx, y, x+dim*0.45, y-dim*0.315);
      bezierVertex(x+dim*0.25*dx, y-dim*0.6*dy, x, y-dim*0.365*dy, x, y-dim*0.25);
      endShape();
      ellipse(x+tam/2, y+tam/2, 2, 2);
    }
  }
  textAlign(LEFT, TOP);
  textFont(helve);
  fill((random(255)*random(1)), 22);
  text("TE QUIERE", bw+1-3, bw*1.3+1);
  fill(255);

  fill(#FFF0F0, 240);
  text("TE QUIERE", bw-3, bw*1.3);
  textFont(helveliviana);
  fill((random(255)*random(1)), 22);
  text("Manolo", bw+1, bw*1.3+36+1);
  fill(255);

  fill(#FFF0F0, 240);
  text("Manolo", bw, bw*1.3+36);
  for (int j = 0; j<height; j++) {
    for (int i = 0; i<width; i++) {
      stroke((random(255)*random(1)), 4);
      point(i, j);
    }
  }
}
