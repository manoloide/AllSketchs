import processing.pdf.*;

void setup() {
  size(960, 960);
  generate();
}

int seed = int(random(9999999));

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else if (key == 'e') {
    beginRecord(PDF, "export.pdf"); 
    generate();
    endRecord();
  } else if (key == 'g') {
    seed = int(random(999999));
    generate();
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(255);

  randomSeed(seed);

  translate(width/2, height/2);
  //scale(0.99);

  int cc = int(random(3, 12));
  float ss = width*0.9/cc;
  //rotate(random(TWO_PI));
  noFill();
  stroke(0);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      //rect(i*ss, j*ss, ss, ss);
      int ccc = int(random(1, 6));
      //ccc = 3;
      //ccc = 4;
      float dd = (ss/ccc);
      float sss = dd*random(0.5, 0.9);
      float mc = ccc*0.5;
      //rectMode(CENTER);
      float x, y, d;
      for (int dy = 0; dy < ccc; dy++) {
        for (int dx = 0; dx < ccc; dx++) {
          d = (dd-sss)*0.5;
          /*
           x = (i-cc*0.5)*ss;
           y = (j-cc*0.5)*ss;
           rect(x, y, ss, ss);
           */
          x = (i-cc*0.5)*ss+d+(dx-mc+ccc*0.5)*dd;
          y = (j-cc*0.5)*ss+d+(dy-mc+ccc*0.5)*dd; 
          rect(x, y, sss, sss);
        }
      }
    }
  }
}