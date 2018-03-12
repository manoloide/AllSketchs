import processing.pdf.*;

int paleta[] = {
  #2DFA5E, 
  #A72DFA
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
  background(40);
  //background(#A6CBD8);
  /*
  noFill();
   for (int i = 100; i < width+height; i+= 50) {
   stroke(rcol(), 40);
   strokeWeight(random(2, 10));
   rombo(width/2, height/2, i);
   }
   */

  noStroke();
  fill(250, 5);
  int s = 5;
  for (int j = s/2; j < height; j+=s) {
    for (int i = s/2; i < width; i+=s) {
      int tt = int(s*0.5 + s*0.3 *(((i+j)/s)%2));
      rect(i-tt/2, j-tt/2, tt, tt);
    }
  }

/*
  for (int i = 0; i < 100; i++) {
    float a = random(TWO_PI);
    float des = random(200);
    float x = width/2+cos(a)*des; 
    float y = height/2+sin(a)*des; 
    float t = random(10, 80);
    float ang = random(TWO_PI);
    fill(paleta[0]);
    arc(x, y, t, t,  ang-TWO_PI, ang-PI);
    fill(paleta[1]);
    arc(x, y, t, t,  ang+PI, TWO_PI+ang);
  }
  */



  int c = int(random(8, 16));
  for (int i = 0; i < c; i++) {
    float x = width/2 + randomGaussian()*width*0.2;
    float y = height/2 + randomGaussian()*height*0.2;
    float w = random(10, 40);
    float h = w*1.4;
    stroke(250, 20);

    strokeCap(SQUARE);
    strokeWeight(w/20);
    for (float  j = y; j < height; j+=w/5) {
      line(x, j, x, j+w/8);
    }

    fill(255, 3);
    noStroke();
    ellipse(x, y, h*1.7, h*1.7);

    float a = random(PI);
    strokeWeight(w/5);
    noFill();
    color col = rcol();//color(random(256), random(256), random(256));//rcol();
    stroke(col);
    arc(x, y, h*1.4, h*1.4, PI*1.5-a, PI*1.5+a);
    stroke(col, 80);
    arc(x, y, h*1.4, h*1.4, PI*1.5+a, PI*1.5-a+TWO_PI);

    noStroke();
    fill(240);
    beginShape();
    vertex(x-w/2, y);
    vertex(x, y-h/2);
    vertex(x+w/2, y);
    vertex(x, y+h/2);
    endShape(CLOSE);
    fill(0, 10);
    beginShape();
    vertex(x, y-h/2);
    vertex(x+w/2, y);
    vertex(x, y+h/2);
    endShape(CLOSE);
    fill(0, 30);
    beginShape();
    vertex(x-w/2, y);
    vertex(x, y+h/2);
    vertex(x+w/2, y);
    endShape(CLOSE);
  }

  
  fill(250);
   for (int i = 0; i < 10; i++) {
   float x = random(width);
   float y = random(height);
   float d = random(60, 220);
   noStroke();
   nube(x, y, d);
   stroke(0, 10);
   cross(x, y-d/8, 4);
   }
   
  endRecord();
}

void nube(float x, float y, float d) {
  float t1 = d/2*random(0.6, 1.6);
  float t2 = d/2*random(0.6, 1.6);
  float t3 = d/2*random(0.6, 1.6);
  arc(x-d/4, y, t1, t1, PI, TWO_PI, 1);
  arc(x, y, t2, t2, PI, TWO_PI, 1);
  arc(x+d/4, y, t3, t3, PI, TWO_PI, 1);

  stroke(0, 20);
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

