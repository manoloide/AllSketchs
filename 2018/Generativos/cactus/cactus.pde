import peasy.*;

int seed = int(random(999999));
PeasyCam cam;

void setup() {
  size(720, 720, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(4000);

  smooth(8);
  pixelDensity(2);

  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(80);


  randomSeed(seed);

  //translate(width/2, height/2);


  stroke(200);
  noFill();
  translate(0, 0, -200);
  cactus(8, 50, 80);
}


void cactus(int sub, int div, float r) {
  float da = TWO_PI/sub;
  for (int k = 0; k < 40; k++) {
    float h = map(k, 0, 40, 0, r*20);
    beginShape();
    for (int i = 0; i < sub; i++) {
      float ang = i*da;
      for (int j = 0; j < div; j++) {
        float rr = map(pow(sin(j*1./div*PI), 4), 0, 1, r*0.7, r); 
        vertex(cos(ang)*rr, sin(ang)*rr, h);
        ang += da/div;
      }
    }
    endShape(CLOSE);
  }
} 

PVector displace(PVector v, float des, float det) {
  float a = noise(des+v.x*det, des+v.y*det)*TWO_PI;
  float d = noise(1000+des+v.x*det, 1000+des+v.y*det)*300;
  return new PVector(v.x+cos(a)*d, v.y+sin(a)*d);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+".png");
}

//int colors[] = {#DF2601, #7A04C4, #1DCCBB, #F4F4F4, #FFD71D};
int colors[] = {#EA554F, #FAC745, #2760AB, #369952, #1E2326, #FFF7F3}; 
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