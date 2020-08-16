int seed = int(random(9999999));

void setup() {
  size(720, 720, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}


void draw() {
  //if (frameCount%120 == 0) seed = int(random(9999999));
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(9999999));
    generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  float size = dist(0, 0, width, height);
  int col1 = rcol();
  int col2 = rcol();
  while (col2 == col1) col2 = rcol();
  int col3 = rcol();
  while (col3 == col1 || col3 == col2) col3 = rcol();
  int sub = int(random(40, 260));
  sub -= sub%2;
  background(col1);
  noStroke();
  for (int i = 0; i < 20; i++) {
    float ss = (size*2./sub)*(int(random(sub*0.1, sub*0.4)));

    int rnd = int(random(3));

    shadow(int(random(2)), sub);
    if (i == 0) fill(rcol());
    else fill(rcol());
    if (rnd == 0) ellipse(width/2, height/2, ss, ss); 
    else if (rnd == 1) {
      if (random(1) < 0.5) {
        if (random(1) < 0.5) triangle(0, 0, width, height, width, 0);
        else triangle(0, height, width, height, width, 0);
      } else {
        if (random(1) < 0.5)  triangle(0, height, width, height, 0, 0);
        else triangle(0, height, width, 0, 0, 0);
      }
    }
  }
}

void shadow(int dir, int cc) {
  float size = dist(0, 0, width, height);
  float ss = size/cc;
  pushMatrix();
  translate(width/2, height/2);
  rotate(HALF_PI*(dir+0.5));
  translate(-size*0.5, -size*0.5);
  for (int i = 0; i < cc; i++) {
    beginShape();
    if (i%2 == 0) fill(0, 10);
    else fill(255, 0);
    vertex(i*ss, 0);
    vertex(i*ss+ss, 0);
    if (i%2 == 0) fill(0, 0);
    else fill(255, 10);
    vertex(i*ss+ss, size);
    vertex(i*ss, size);
    endShape();
  }
  popMatrix();
}

int colors[] = {#EBB858, #EEA8C1, #D0CBC3, #87B6C4, #EA4140, #5A5787};//, #D0CBC3, #87B6C4, #EA4140, #5A5787};
int rcol() {
  return colors[int(random(colors.length))];
};
int getColor(float v) {
  v = v%(colors.length);
  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;
  return lerpColor(c1, c2, m);
}