int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}


void generate() {

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  int cc = int(random(8, 45));
  float sep = width*1./cc;

  noStroke();
  int col = rcol();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      if (random(1)*random(0.5, 1) < 0.02) col = rcol();
      int alt = rcol();
      fill(lerpColor(col, alt, random(0.2)));
      rect(i*sep, j*sep, sep, sep);
    }
  }
  
  noStroke();
  for(int i = 0; i < 300000; i++){
     float xx = random(width);
     float yy = random(height);
     float ss = width*random(0.001);
     fill(lerpColor(rcol(), color(255), random(1)), random(255));
     ellipse(xx, yy, ss, ss);
  }
  
  int cd = int(random(10, 40));
  for(int i = 0; i < cd; i++){
     float x = random(width);
     float y = random(height);
     float s = sep*int(random(1, random(1, 12)));
     beginShape();
     fill(rcol(), random(random(255), 255));
     vertex(x-s*0.5, y-s*0.5);
     vertex(x+s*0.5, y-s*0.5);
     fill(rcol(), random(random(255), 255));
     vertex(x+s*0.5, y+s*0.5);
     vertex(x-s*0.5, y+s*0.5);
     endShape(CLOSE);
  }

  strokeWeight(2);
  for (int i = 0; i < 10; i++) {
    float x = random(width);
    float y = random(height);
    x -= x%sep;
    y -= y%sep;
    float a = int(random(4))*HALF_PI;
    float ax = x;
    float ay = y;
    stroke((random(1) < 0.5? 0 : 255), 200);
    for (int j = 0; j < 100; j++) {
      a += int(random(-2, 2))*HALF_PI;
      x += cos(a)*sep;
      y += sin(a)*sep;
      line(ax, ay, x, y);
      ax = x;
      ay = y;
    }
  }

  for (int i = 0; i < 20; i++) {
    float x = random(width);
    float y = random(width);
    float s = sep*0.4;
    x -= x%sep;
    x += sep*0.5;
    y -= y%sep;
    y += sep*0.5;
    noStroke();
    fill(rcol());
    ellipse(x, y, s, s);
  }
  
  rectMode(CENTER);
  for(int i = 0; i < 100; i++){
     float x = random(width);
     float y = random(height);
     float w, h;
     w = h = width*random(0.1);
     if(random(1) < 0.5) w *= 1/int(random(2, 8));
     else h *= 1/int(random(2, 8));
     fill(rcol());
     rect(x, y, w, h);
  }
  rectMode(ROUND);
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FFFEF8, #FAE0E0, #E66B85, #AFE9E5, #64B9DA, #427FAD, #3C5A81, #252B22, #539A6D, #ADBF83};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}
