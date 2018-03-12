import processing.pdf.*;

boolean savePDF = true;
int seed = 8;

int paleta[] = {
  #FF9900, 
  #424242, 
  #E9E9E9, 
  #BCBCBC, 
  #3299BB
};

void setup() {
  size(700, 1000);
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  if (keyCode == LEFT) {
    seed--;
    generar();
  }
  if (keyCode == RIGHT) {
    seed++;
    generar();
  } else {
    generar();
  }
}

void generar() {
  //background(rcol());
  /*
  stroke(250, 20);
   float des = random(2, 5);
   for (int i = -int (random (des)); i < width+height; i+=des) {
   line(i, -2, -2, i);
   }
   */
  randomSeed(seed);
  if (savePDF)beginRecord(PDF, seed+".pdf");
  background(paleta[3]);
  //background(255, 0, 255);
  int cantidad = 5000;
  noStroke();
  for (int i = 0; i < cantidad; i++) {
    //if ((i+1)%100 == 0) frame.setTitle(i*1./cantidad*100+"% "+seed);
    float x = random(width); 
    float y = random(height); 
    /*
    float a = random(TWO_PI);
     float d = (width/2)*random(0.7);
     float x = width/2+cos(a)*d;
     float y = height/2+sin(a)*d;
     */
    float ang = random(TWO_PI);
    float t = random(10, 20);
    float vel;
    while (t > 0.2) {
      ang += random(-0.1, 0.1);
      vel = map(t, 0.1, 20, t*0.2, t*0.04);
      //map(t, 0.1, 100, 0.02, 1.8);
      x += cos(ang)*vel;
      y += sin(ang)*vel;
      t *= random(0.98, 0.99);
      //t -= random(0.5);
      fill(rcol());
      ellipse(x, y, t, t);
    }
  }
  if (savePDF)endRecord();
  exit();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}