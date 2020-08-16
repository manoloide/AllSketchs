color paleta[] = {
  #FFF3EB, #FFEED4, #F0CFCC, #BFCFDE, #ABBECF
};

void setup() {
  size(600, 800, P2D);
  smooth(16);
  generar();
}

void draw() {
}

void generar() {
  background(rcol());
  float tam = random(10, 160);
  int cw = int(width/tam)+2;
  int ch = int(height/tam)+2;
  cuadricula(-(width%tam)/2, -(height%tam)/2, cw*tam, ch*tam, tam, random(tam/8, tam/2));
  float tt = 20;
  for (int i = 0; i < 200; i++) {
    float x = random(width);
    float y = random(height);
    stroke(0, 2);
    noFill();
    for(int j = 1; j <= 4; j++){
      strokeWeight(j);
      ellipse(x, y, tt, tt);
    }
    noStroke();
    fill(rcol()); 
    ellipse(x, y, tt, tt);
  }
}

void keyPressed() {
  if (key == 's') saveFrame("######.png");
  else generar();
}

color rcol() {
  return paleta[int(random(paleta.length))];
}

void cuadricula(float x, float y, float w, float h, float tam, float noi) {
  int cw = int(w/tam);
  int ch = int(h/tam);
  PVector puntos[][] = new PVector[cw][ch]; 
  noStroke();
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float ang = random(TWO_PI);
      float des = random(-noi, noi);
      float xx = i*tam+cos(ang)*des;
      float yy = j*tam+sin(ang)*des;
      puntos[i][j] = new PVector(xx, yy);
      fill(rcol());
      if (i > 0 && j > 0) {
        beginShape();
        vertex(puntos[i-1][j-1].x, puntos[i-1][j-1].y);
        vertex(puntos[i][j-1].x,puntos[i][j-1].y);
        vertex(puntos[i][j].x,puntos[i][j].y);
        vertex(puntos[i-1][j].x,puntos[i-1][j].y);
        endShape(CLOSE);
      }
    }
  }
}

