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

void generar() {
  background(#F0F0F0);
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
      float x = bw+dw*i;
      float y = bh+dh*j +(height-width-dh);
      float w, h;
      w = h = tam;
      float kappa = 0.5522848;
      float ox = (w / 2) * kappa * map(i, 0, cant, 1, 0);
      float oy = (h / 2) * kappa * map(i, 0, cant, 1, 0);
      float ox2 = (w / 2) * kappa * map(j, 0, cant, 1, 0);
      float oy2 = (h / 2) * kappa * map(j, 0, cant, 1, 0);
      float xe = x + w;
      float ye = y + h;
      float xm = x + w / 2;
      float ym = y + h / 2;
      fill(255);
      beginShape();
      vertex(x, ym);
      bezierVertex(x, ym - oy, xm - ox, y, xm, y);
      bezierVertex(xm + ox2, y, xe, ym - oy2, xe, ym);
      bezierVertex(xe, ym + oy, xm + ox, ye, xm, ye);
      bezierVertex(xm - ox2, ye, x, ym + oy2, x, ym);
      endShape(CLOSE);
      ellipse(x+tam/2, y+tam/2, 2, 2);
    }
  }
  textAlign(LEFT, TOP);
  textFont(helve);
  fill((random(255)*random(1)), 22);
  text("CAMBIOS RAPIDOS", bw+1-3, bw*1.3+1);
  fill(255);
  text("CAMBIOS RAPIDOS", bw-3, bw*1.3);
  textFont(helveliviana);
  fill((random(255)*random(1)), 22);
  text("Manolo", bw+1, bw*1.3+36+1);
  fill(255);
  text("Manolo", bw, bw*1.3+36);
  for (int j = 0; j<height; j++) {
    for (int i = 0; i<width; i++) {
      stroke((random(255)*random(1)), 4);
      point(i, j);
    }
  }
}
