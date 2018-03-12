int paleta[] = {
  #ff5108, 
  #fffdf8, 
  #ff2321, 
  #000000, 
  #f7ff3f
};

void setup() {
  size(800, 800);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else thread("generate");
}

void generate() {
  background(mcol());
  int sep = int(random(8, 30));
  strokeWeight(sep*random(0.2, 0.5));
  stroke(255, 80);
  for (int i = int (random (-sep)); i < width+height; i+=sep) {
    line(-2, i, i, -2);
  }
  for (int j = 0; j < 220; j++) {
    float x = random(width); 
    float y = random(height);
    float d = random(10, random(80, 420)*random(1));
    noFill();
    stroke(0, 8);
    for (int i = 5; i >= 1; i--) {
      strokeWeight(i);
      ellipse(x, y, d, d);
    }
    noStroke();
    fill(random(220, 240));
    ellipse(x, y, d, d);

    stroke(0, 40);
    strokeWeight(d*0.005);
    line(x-d*0.34, y-d*0.34, x+d*0.34, y+d*0.34);
    line(x+d*0.34, y-d*0.34, x-d*0.34, y+d*0.34);
    float a1 = random(TWO_PI);
    float a2 = a1+random(TWO_PI);
    stroke(0);
    strokeWeight(d*0.01);
    arc(x, y, d*0.92, d*0.92, a1, a2);
    stroke(255);
    arc(x, y, d*0.92, d*0.92, a2, a1+TWO_PI);
    int cc = int(random(3, 9));
    float ang = PI*1.5;
    float da = TWO_PI/cc;
    strokeCap(SQUARE);
    noFill();
    float r1 = random(0.56, 0.72);
    for (int i = 0; i < cc; i++) {
      stroke(map(i, 0, cc, 0, 100), 240);
      stroke(rcol());
      strokeWeight(d*random(0.04, 0.12));
      arc(x, y, d*r1, d*r1, da*i+ang, da*(i+1)+ang);
    }
    noStroke();
    fill(0, 20);
    ellipse(x, y, d*0.4, d*0.4);
    fill(mcol());
    ellipse(x, y, d*0.35, d*0.35);
    fill(255, 80);
    ellipse(x+d*0.05, y-d*0.05, d*0.13, d*0.13);
    ellipse(x+d*0.05, y-d*0.05, d*0.08, d*0.08);
  }

  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float d = random(3, 20);
    float a = random(TWO_PI);
    float s = random(0.2, 0.5);
    noFill();
    stroke(0, 8);
    for (int j = 5; j >= 1; j--) {
      strokeWeight(j);
      cross(x, y, d, a, s);
    }
    noStroke();
    fill(rcol());
    cross(x, y, d, a, s);
  }
}

void cross(float x, float y, float d, float a, float s) {
  float r = d*0.5;
  float sep = r*s;
  float r2 = dist(sep, 0, 0, sep);
  float da = TWO_PI/4;
  beginShape();
  for (int i = 0; i < 4; i++) {
    float ang = a+da*i;
    vertex(x+cos(ang-PI/4)*r2, y+sin(ang-PI/4)*r2);
    float sx = cos(ang-PI/2)*sep; 
    float sy = sin(ang-PI/2)*sep;
    float xx = x+cos(ang)*r;
    float yy = y+sin(ang)*r;
    vertex(xx+sx, yy+sy);
    vertex(xx-sx, yy-sy);
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

int mcol() {
  return lerpColor(rcol(), rcol(), random(1));
}

