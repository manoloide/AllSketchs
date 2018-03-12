PColor pc = new PColor();

void setup() {
  size(600, 600, P2D);
  generar();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  beginShape();
  fill(20);
  vertex(0, 0);
  vertex(width, 0);
  fill(50);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);
  pc.randomPaletta(2);
  for (int i = 0; i < 100; i++) {
    int c = 3;
    float ang = random(TWO_PI);
    float da = TWO_PI/c;
    float x = random(width);
    float y = random(height);
    float r = random(5, 80);
    color col = pc.rcol();
    beginShape();
    noFill();
    stroke(0, 8);
    for (int k = 6; k > 0; k--) {
      strokeWeight(k);
      for (int j = 0; j < c; j++) {
        vertex(x+cos(ang+da*j)*r, y+sin(ang+da*j)*r);
      }
    }
    endShape(CLOSE);
    beginShape();
    noStroke();
    for (int j = 0; j < c; j++) {
      if (j == 0) {
        color a = pc.mod(col, -20);
        fill(pc.b(a, -10));
      } else {
        fill(col);
      }
      vertex(x+cos(ang+da*j)*r, y+sin(ang+da*j)*r);
    }
    endShape(CLOSE);
  }
  strokeCap(SQUARE);
  for (int i = 0; i < 50; i++) {
    float r = random(5)*random(1);
    float x = random(width); 
    float y = random(height);
    stroke(pc.rcol());
    strokeWeight(r*0.8);
    line(x-r, y-r, x+r, y+r);
    line(x-r, y+r, x+r, y-r);
  }
  
  blendMode(BLEND);

  /*
  PGraphics aux = createGraphics(width, height); 
  aux.beginDraw();
  aux.copy(g, 0, 0, width, height, 0, 0, width, height);
  aux.filter(BLUR, 2);
  aux.endDraw();
  blendMode(LIGHTEST);
  //tint(255, 30);
  //image(aux, 0, 0);
  //aux.filter(BLUR, 10);
  image(aux, 0, 0);
  blendMode(BLEND);
  */
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 3)+".png");
}
