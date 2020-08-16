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
  background(0);

  float fov = PI/random(1.0, 1.3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*1000.0);

  translate(width/2, height/2, 400);
  rotateX(-HALF_PI);

  randomSeed(seed);
  //translate(random(width), random(height), 0);
  //

  rotateX(HALF_PI*random(-1, 1));
  rotateY(HALF_PI*random(-1, 1));


  for (int i = 0; i < 300; i++) {
    pushMatrix();
    translate(0, 0, random(-width*6, width*6));
    v(random(10000), random(4, 220)*random(1), int(random(2, 1000)));
    popMatrix();
  }
}

void v(float s, float h, int sub) {
  float ang = PI*1.5;
  float amp = random(HALF_PI*0.2, HALF_PI);
  float mh = h*0.5;

  float x1 = cos(ang+amp)*s;
  float y1 = sin(ang+amp)*s;
  float x2 = cos(ang-amp)*s;
  float y2 = sin(ang-amp)*s;

  noStroke();
  for (int i = 0; i < sub; i++) {

    float m1 = map(i, 0, sub, 0, 1);
    float m2 = map(i+1, 0, sub, 0, 1);

    if (i%2 == 0) fill(255);
    else fill(0);
    beginShape();
    vertex(x1*m1, y1*m1, +mh);
    vertex(x1*m1, y1*m1, -mh);
    vertex(x1*m2, y1*m2, -mh);
    vertex(x1*m2, y1*m2, +mh);
    endShape(CLOSE);


    if (i%2 == 1) fill(255);
    else fill(0);
    beginShape();
    vertex(x2*m1, y2*m1, +mh);
    vertex(x2*m1, y2*m1, -mh);
    vertex(x2*m2, y2*m2, -mh);
    vertex(x2*m2, y2*m2, +mh);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


//int colors[] = {#18204a, #1aade2, #53a965, #FFD362, #ff752f, #ff5d64};
int colors[] = {#191F5A, #5252C1, #9455F9, #FFA1FB, #FFFFFF, #51C3C4, #EE4764, #FFA1FB, #E472E8, #FFB452};
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