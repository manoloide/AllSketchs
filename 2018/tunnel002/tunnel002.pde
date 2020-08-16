import peasy.*;

PeasyCam cam;

int seed = int(random(999999));
PShader mirror;

void setup() {
  size(720, 720, P3D);
  smooth(8);
  //pixelDensity(2);

  frameRate(30);

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(100);

  mirror = loadShader("mirror.glsl");
  mirror.set("resolution", float(width), float(height));

  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    //generate();
  }
}

void generate() {

  randomSeed(seed);
  noiseSeed(seed);

  float time = millis()*0.001;

  background(0);


  //lights();
  //translate(width/2, height/2);
  rotateX(-HALF_PI);

  int sub = int(random(60, 100)); //260
  int div = int(random(10, 100)); //80
  float r = height/1.6;
  float hh = 1400;

  float vel = random(-2, 2)*random(1);

  float da = TWO_PI/sub;
  float det = random(0.5)*random(0.8, 1);
  float des = random(10000);
  float dh = random(0.01)*random(1);
  stroke(255);

  ArrayList<PVector> points = new ArrayList<PVector>();
  IntList colors1 = new IntList();
  IntList colors2 = new IntList();
  float aic = random(1000);
  float adc = random(1);

  float h, ic, dc, vc, dx, dy, rr;
  vc = time*random(-1.0, 1.0);
  for (int j = 0; j <= div; j++) {
    h = map(j, 0, div, 0, hh);
    ic = random(1000);
    dc = random(1)*random(1);
    for (int i = 0; i < sub; i++) {
      dx = cos(da*i);
      dy = sin(da*i);
      rr = noise(dx*det+des, h*dh+time*vel, dy*det+des)*r;
      rr *= cos(map(j, 0, div, 0, HALF_PI));
      points.add(new PVector(dx*rr, h, dy*rr));
      colors1.push(getColor(noise(dx*dc, dy*dc, vc+ic)*colors.length*2));
      colors2.push(getColor(noise(dx*adc, dy*adc, vc+aic)*colors.length*2));
    }
    aic = ic;
    adc = dc;
  }

  int ind;
  PVector p;
  //stroke(0);
  noStroke();
  for (int j = 0; j < div; j++) {
    for (int i = 0; i < sub; i++) {
      beginShape();
      ind = j*sub+i;
      p = points.get(ind);
      fill(colors1.get(ind));
      vertex(p.x, p.y, p.z);
      ind = (j+1)*sub+i;
      p = points.get(ind);
      fill(colors2.get(ind));
      vertex(p.x, p.y, p.z);
      ind = (j+1)*sub+(i+1)%sub;
      p = points.get(ind);
      fill(colors2.get(ind));
      vertex(p.x, p.y, p.z);
      ind = j*sub+(i+1)%sub;
      p = points.get(ind);
      fill(colors1.get(ind));
      vertex(p.x, p.y, p.z);
      endShape(CLOSE);
    }
  }

  mirror = loadShader("mirror.glsl");
  mirror.set("time", time);
  filter(mirror);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
//int colors[] = {#2F2624, #207193, #EF4C31, #EE4E7C, #ffffff};
int colors[] = {#EDD198, #FCB84C, #FF614C, #0077C4, #55C3C6, #F396BF, #202020};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void shuffleArray(int[] array) {
  for (int i = array.length; i > 1; i--) {
    int j = int(random(i));
    int tmp = array[j];
    array[j] = array[i-1];
    array[i-1] = tmp;
  }
}
