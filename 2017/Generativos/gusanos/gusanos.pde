int seed = int(random(999999));

void setup() {
  size(720, 720);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  float time = millis()*0.001;

  noiseSeed(seed);
  randomSeed(seed);

  det = random(0.012)*random(1);
  des = random(1000);
  amp = random(800)*random(1)*random(1);

  background(rcol());

  int cc = 8;//int(random(3, 17));
  float hh = height;
  int dd = 10;
  int init = -dd-ceil(amp);
  int end = width+dd+ceil(amp);
  int c = 10;
  for (int j = 0; j < cc; j++) {
    float yy = 0;
    float det1 = random(0.02)*random(1);
    float det2 = random(0.02)*random(1);
    float des1 = time*random(-1, 1);
    float des2 = time*random(-1, 1);

    noStroke();
    PVector p;
    float xx, dy, a, amp;
    float pwr1 = (random(1) < 0.5)? random(0.5, 1) : random(1, 2);
    float pwr2 = (random(1) < 0.5)? random(0.5, 1) : random(1, 2);
    for (int k = 0; k < c; k++) {
      amp = map(k, 0, c, 3, 0);
      fill(rcol());
      beginShape();
      for (int i = end; i >= init; i-=dd) {
        p = displace(i, yy+hh*0.5);
        curveVertex(p.x, p.y);
      }
      for (int i = init; i <= end; i+=dd) {
        xx = i;
        dy = noise(des1+i*det1, j);
        a = pow(noise(des2+i*det2, j), pwr2);
        dy = constrain(dy-a, 0, 1.0)*hh*amp;
        dy = pow(dy, pwr1);
        p = displace(xx, yy+dy+hh*0.5);
        curveVertex(p.x, p.y);
      }
      endShape(CLOSE);

      fill(rcol());
      beginShape();
      for (int i = end; i >= init; i-=dd) {
        p = displace(i, yy+hh*0.5);
        curveVertex(p.x, p.y);
      }
      for (int i = init; i <= end; i+=dd) {
        xx = i;
        dy = noise(des1+i*det1, j);
        a = pow(noise(des2+i*det2, j), pwr2);
        dy = constrain(dy-a, 0, 1.0)*hh*amp;
        dy = pow(dy, pwr1)*-1;
        p = displace(xx, yy+dy+hh*0.5);
        curveVertex(p.x, p.y);
      }
      endShape(CLOSE);
    }
  }
}

float det, des, amp;

PVector displace(float x, float y) {
  //return new PVector(x, y);
  float ang = noise(x*det+des, y*det+des)*TWO_PI*2;
  float dis = pow(noise(x*det+des, y*det+des), 0.2)*amp;
  return new PVector(x+cos(ang)*dis, y+sin(ang)*dis);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//https://coolors.co/f2f2e8-ffe41c-ef3434-ed0076-3f9afc
int colors[] = {#DB7654, #893D60, #D6241E, #F2AC2A, #3D71B7, #FFEEED, #85749D, #21232E, #5FA25A, #5D8EB4};

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