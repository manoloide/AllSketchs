import processing.pdf.*;
void settings() {
  float widthCm = 14;
  float heightCm = 14;
  float dpi = 150;
  int w = int((widthCm*dpi)/2.54);
  int h = int((heightCm*dpi)/2.54);
  println("Size", w, h);
  size(w, h, PDF, getTimestamp()+".pdf");
}

void setup() {
}

void draw() {
  // Draw something good here
  generar();

  // Exit the program 
  println("Finished.");
  exit();
}

void generar() {
  background(#E9E9E9);
  stroke(250, 20);
  float des = random(2, 5);
  for (int i = -int (random (des)); i < width+height; i+=des) {
    line(i, -2, -2, i);
  }
  for (int i = 0; i < 300; i++) {
    /*
    float x = random(-1.1, 1.1)*(width/2)+width/2; 
     float y = random(-1.1, 1.1)*(height/2)+height/2;
     */


    float a = random(TWO_PI);
    float d = (width/2)*random(0.45);
    float x = width/2+cos(a)*d;
    float y = height/2+sin(a)*d;

    float ang = random(TWO_PI);
    float t = random(40, 120);
    float vel = 1.;//random(0.4, 1.4);
    while (t > 0.05) {
      ang += random(-0.25, 0.25);
      x += cos(ang)*vel;
      y += sin(ang)*vel;
      t *= random(0.95, 1);
      t -= random(0.1);
      noStroke();
      fill(rcol());
      ellipse(x, y, t, t);
      fill(255, 80);
      arc(x, y, t, t, PI, PI*1.5);
      fill(0, 80);
      arc(x, y, t, t, 0, PI*0.5);
    }
  }
}

String getTimestamp() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  return timestamp;
}

int paleta[] = {#FF9900, #424242, #E9E9E9, #BCBCBC, #3299BB};
int rcol() {
  return paleta[int(random(paleta.length))];
}