import processing.pdf.*;

boolean savePDF = true;
int seed = 0;

int paleta[] = {
  #FF9900, 
  #424242, 
  #E9E9E9, 
  #BCBCBC, 
  #3299BB
};

void setup() {
  size(800, 800);
  generar();
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
  int cantidad = 2000;
  for (int i = 0; i < cantidad; i++) {
    float x = random(-1.1, 1.1)*(width/2)+width/2; 
    float y = random(-1.1, 1.1)*(height/2)+height/2; 
    /*
    float a = random(TWO_PI);
     float d = (width/2)*random(0.7);
     float x = width/2+cos(a)*d;
     float y = height/2+sin(a)*d;
     */
    float ang = random(TWO_PI);
    float t = random(10, 100);
    float vel = random(0.4, 0.8);
    while (t > 0.1) {
      ang += random(-0.1, 0.1);
      vel = t*0.025;
      //map(t, 0.1, 100, 0.02, 1.8);
      x += cos(ang)*vel;
      y += sin(ang)*vel;
      t *= random(0.98, 0.99);
      //t -= random(0.5);
      noStroke();
      fill(rcol());
      ellipse(x, y, t, t);
      boolean ligths = false;
      if (ligths) {
        fill(255, 20);
        arc(x, y, t, t, PI, PI*1.5);
        fill(0, 20);
        arc(x, y, t, t, 0, PI*0.5);
      }
    }
  }
  if (savePDF)endRecord();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

