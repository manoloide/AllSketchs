import processing.pdf.*;

int paleta[] = {
  #655643, 
  #80BCA3, 
  #F6F7BD, 
  #E6AC27, 
  #BF4D28
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
  beginRecord(pdf);
  background(rcol());

  int sep = int(random(3, 9));
  strokeWeight(2);
  stroke(rcol(), 60);
  for (int i = -int (random (sep)); i < width+height; i+= sep) {
    line(-2, i, i, -2);
  }


  int t = 18;
  int tt = 18+2;

  for (int j = 0; j < width/tt+1; j++) {
    for (int i = 0; i < height/tt+1; i++) {
      int x = i*tt;
      int y = j*tt;
      int r = int(random(3));
      switch(r) {
      case 0:
        noStroke();
        fill(rcol());
        ellipse(x, y, t, t);
        break;
      case 1:
        stroke(rcol());
        cross(x, y, t*cos(PI/4));
        break;
      case 2:
        noStroke();
        fill(rcol());
        rombo(x, y, t);
        break;
      }
    }
  }
  /*
  for (int i = 0; i < 100; i++) {
   float x = random(width);
   float y = random(height);
   float t = random(20, 100);
   fill(rcol());
   ellipse(x, y, t, t);
   }
   */
  endRecord();
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

