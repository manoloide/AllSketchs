import processing.pdf.*;

int paleta[] = {
  #79E8BE, 
  #C6D31A, 
  #FFA731, 
  #FF7A2E, 
  #0E1C1A
};

PGraphicsPDF pdf;

void setup() {
  size(600, 600);
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generar();
}

void generar() {
  int n = (new File(sketchPath)).listFiles().length-1;
  pdf = (PGraphicsPDF) createGraphics(width, height, PDF, nf(n, 3)+".pdf");
  //beginRecord(pdf);
  background(paleta[4]);
  for (int i = 0; i < 500; i++) {
    float x = random(width); 
    float y = random(height);
    float t = 10+random(200)*random(1);
    int ld = int(random(3, 9));
    float ang = random(TWO_PI);
    int c = int(random(t/20));
    noStroke();
    for (int j = c; j > 0; j--) {
      fill(rcol());
      poly(x, y, t/c*j, ld, ang);
    }
  }
  //endRecord();
}

void poly(float x, float y, float d, int l, float a) {
  float r = d/2;
  float da = TWO_PI/l;
  beginShape();
  for (int i = 0; i < l; i++) {
    vertex(x+cos(da*i+a)*r, y +sin(da*i+a)*r);
  }
  endShape(CLOSE);
}

void rombo(float x, float y, float d) {
  d /= 2;
  beginShape();
  vertex(x-d, y);
  vertex(x, y-d);
  vertex(x+d, y);
  vertex(x, y+d);
  endShape(CLOSE);
}

void cross(float x, float y, float d) {
  d /= 2.;
  pushStyle();
  strokeWeight(d*0.6);
  strokeCap(SQUARE);
  line(x-d, y-d, x+d, y+d);
  line(x-d, y+d, x+d, y-d);
  popStyle();
}

void saveImage() {
}


int rcol() {
  return paleta[int(random(paleta.length))];
}

