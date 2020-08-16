int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
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
  background(20);
  randomSeed(seed);

  int ss = 40;
  /*
    stroke(30);
   strokeWeight(1);
   for (int i = 0; i <= width; i+=ss) {
   line(i, 0, i, height);
   line(0, i, width, i);
   }
   
   stroke(20);
   fill(30);
   strokeWeight(2);
   rectMode(CENTER);
   for (int j = 0; j <= height; j+=ss) {
   for (int i = 0; i <= width; i+=ss) {
   rect(i, j, 4, 4);
   }
   }
   */

  fill(#C6AD6C);
  lights();
  noStroke();

  specular(#C6AD6C);
  shininess(10.0);
  //circles(width/2, height/2, width*random(0.1, 0.4), int(random(8, 361)));

  int ccc = int(random(3, 9));
  for (int j = 0; j < 20; j++) {
    int cc = ccc*int(random(1, 5));
    float r = width*random(0.4);
    float da = TWO_PI/cc;
    float cx = width/2;
    float cy = height/2;
    int c = int(random(8, 220));
    float s2 = r*random(0.8);

    int rnd = int(random(2));

    if (rnd == 0) {
      for (int i = 0; i < cc; i++) {
        float ang = PI*1.5+da*i;
        float x = cx+cos(ang)*r;
        float y = cy+sin(ang)*r;
        circles(x, y, s2, c);
      }
    }
    if (rnd == 1) {
      float ss1 = s2*random(1);
      float ss2 = s2*random(1);
      for (int i = 0; i < cc; i++) {
        float ang = PI*1.5+da*i;
        float x = cx+cos(ang)*r;
        float y = cy+sin(ang)*r;
        pushMatrix();
        translate(x, y);
        rotate(ang);
        crystal(ss1, ss2);
        popMatrix();
      }
    }
  }
}

void crystal(float w, float h) {
  float mw = w*0.5;
  float mh = h*0.5;
  float d = 10;//max(w, h)*0.6;
  beginShape();
  vertex(-mw, 0, 0);
  vertex(0, -mh, 0);
  vertex(0, 0, d);
  endShape(CLOSE);
  beginShape();
  vertex(+mw, 0, 0);
  vertex(0, -mh, 0);
  vertex(0, 0, d);
  endShape(CLOSE);
  beginShape();
  vertex(+mw, 0, 0);
  vertex(0, +mh, 0);
  vertex(0, 0, d);
  endShape(CLOSE);
  beginShape();
  vertex(-mw, 0, 0);
  vertex(0, +mh, 0);
  vertex(0, 0, d);
  endShape(CLOSE);
}

void circles(float x, float y, float s, int c) {
  float r = s*0.5;
  float da = TWO_PI/c;
  float size = PI*r/c;
  for (int i = 0; i < c; i++) {
    float ang = da*i;
    pushMatrix();
    translate(x+cos(ang)*r, y+sin(ang)*r);
    sphere(size);
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#db3b4b, #edd23b, #d4dbdd, #2172ba};
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