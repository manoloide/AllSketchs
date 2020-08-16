void setup() {
  size(800, 800);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
  background(252);
  int c = int(random(2, 5));

  for (int j = 0; j < c; j++) {
    stroke(random(80)*random(1), random(180, 240));
    //stroke(rcol());
    float det = random(0.05)*random(1);
    float amp = random(2, 100)-100*det;
    float gro = random(2, 8);
    boolean ig = (random(1) < 0.5)? true : false;
    int cant = int(random(10000, 100000*(c-j)));
    noiseSeed(int(random(1000000)));
    for (int i = 0; i < cant; i++) {
      float x = random(-50, width+50);
      float y = random(-50, height+50);
      float a = noise(x*det, y*det)*TWO_PI;
      float d = noise(x*det, y*det)*amp;//random(2);
      strokeWeight(gro/((ig)? d : amp-d));
      line(x, y, x+cos(a)*d, y+sin(a)*d);
    }
  }

  float det = random(0.0005, 0.005);
  noiseSeed(int(random(1000000)));
  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float y = random(height);
    float n = (noise(x*det, y*det)-0.5)*2;
    if (n < 0) continue;
    float d = pow(n*5, 1.4)*3;
    if (d < 2) continue;
    strokeWeight(d*0.08);
    fill(255);
    stroke(0);
    ellipse(x, y, d, d);
    ellipse(x, y, d*0.1, d*0.1);
  }
}

int colors[] = {
  #E8DDCB, 
  #CDB380, 
  #036564, 
  #033649, 
  #031634
};

int rcol() {
  return colors[int(random(colors.length))];
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

