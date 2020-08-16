int seed = int(random(9999999)); 
PImage img1, img2;

void setup() {
  size(960, 720, P3D);
  smooth(8);
  pixelDensity(2);
  rectMode(CENTER);

  img1 = loadImage("tex1.jpg");
  img2 = loadImage("tex2.jpg");
}

void draw() {

  float time = (millis()*0.0001);

  noiseSeed(seed);
  noiseDetail(1);
  randomSeed(seed);

  background(0);
  float fov = PI/random(1.01, 1.2);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*100.0);

  float dir = noise(time*random(10))*TWO_PI*2;
  float dis = noise(time*random(10))*random(2000);
  translate(width/2+cos(dir)*dis, height/2+sin(dir)*dis);
  rotate(time*random(-0.1, 0.1));

  strokeWeight(2);

  float dd = width;
  float ss = dd*sqrt(2)*2;
  int cc = 20;
  float vel = random(10)*random(0.1, 1);
  for (int i = 0; i < 4; i++) {
    for (int k = 0; k < cc; k++) {
      float ang = i*HALF_PI;
      float x = cos(ang)*sqrt(2)*dd;
      float y = sin(ang)*sqrt(2)*dd;
      float z = ((k+time*vel)%cc-cc*0.6)*ss;
      pushMatrix();
      translate(x, y, z);
      rotate(ang);
      rotateY(HALF_PI);

      gricula(ss, int(random(2, 20)));
      popMatrix();
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
  }
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void gricula(float s, int sub) {
  ArrayList<PVector> quads = new ArrayList<PVector>();
  quads.add(new PVector(0, 0, s));
  for (int i = 0; i < sub; i++) {
    int ind = int(random(quads.size()));
    PVector q = quads.get(ind);
    float ms = q.z*0.5;
    float mm = ms*0.5;
    quads.add(new PVector(q.x-mm, q.y-mm, ms));
    quads.add(new PVector(q.x+mm, q.y-mm, ms));
    quads.add(new PVector(q.x+mm, q.y+mm, ms));
    quads.add(new PVector(q.x-mm, q.y+mm, ms));
    quads.remove(ind);
  }

  for (int i = 0; i < quads.size(); i++) {
    PVector q = quads.get(i);
    fill(rcol());
    textureRect(q.x, q.y, q.z, q.z);
  }
}

void textureRect(float x, float y, float w, float h) {
  float mw = w*0.5;
  float mh = h*0.5;

  float sw = random(1);
  float sh = random(1);
  float tx = random(0, 1-sw);
  float ty = random(0, 1-sh);
  textureMode(NORMAL);
  noStroke();
  beginShape();
  if (random(1) < 0.5)texture(img1);
  else texture(img2);
  vertex(x-mw, y-mh, tx, ty);
  vertex(x+mw, y-mh, tx+sw, ty);
  vertex(x+mw, y+mh, tx+sw, ty+sh);
  vertex(x-mw, y+mh, tx, ty+sh);
  endShape(CLOSE);
}

int colors[] = {#db3b4b, #edd23b, #d4dbdd, #2172ba};
int rcol() {
  //return color(255);
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