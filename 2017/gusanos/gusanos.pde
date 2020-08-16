int seed = int(random(999999));

void setup() {
  size(720, 720, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  if (frameCount%40 == 0) seed = int(random(9999999));
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

  float time = millis()*0.001;

  noiseSeed(seed);
  randomSeed(seed);

  det = random(0.02)*random(1)*random(1);
  des = random(1000);
  amp = random(300)*random(1);

  //background(rcol());
  fill(rcol(), 200);
  rect(0, 0, width, height);

  int cc = int(random(3, 13));
  float ww = width*1./cc;
  for (int j = 0; j < cc; j++) {
    float xx = ww*j;
    float det1 = random(0.02)*random(1);
    float det2 = random(0.02)*random(1);
    float des1 = time*random(-1, 1);
    float des2 = time*random(-1, 1);
    noStroke();
    int c = 5;
    for (int k = 0; k < c; k++) {
      float amp = map(k, 0, c, 1, 0);

      fill(rcol());
      beginShape();
      vertex(xx+ww*0.5, 0);
      for (int i = 0; i < height; i+=5) {
        float yy = i;
        float dx = noise(des1+i*det1, j, 0);
        float a = noise(des2+i*det2, j);
        dx = constrain(dx-a, 0, 1.0)*ww*amp;
        //dx = ww*amp;
        PVector p = displace(xx+dx+ww*0.5, yy);
        vertex(p.x, p.y);
      }
      vertex(xx+ww*0.5, height);
      endShape(CLOSE);

      fill(rcol());
      beginShape();
      vertex(xx+ww*0.5, 0);
      for (int i = 0; i < height; i+=5) {
        float yy = i;
        float dx = noise(des1+i*det1, j, 0);
        float a = noise(des2+i*det2, j);
        dx = constrain(dx-a, 0, 1.0)*ww*amp*-1;
        //dx = ww*amp*-1;
        PVector p = displace(xx+dx+ww*0.5, yy);
        vertex(p.x, p.y);
      }
      vertex(xx+ww*0.5, height);
      endShape(CLOSE);
    }
  }
}

float det, des, amp;

PVector displace(float x, float y) {
  return new PVector(x, y);
  /*
  float ang = noise(x*det+des, y*det+des)*TWO_PI*2;
   float dis = noise(x*det+des, y*det+des)*amp;
   return new PVector(x+cos(ang)*dis, y+sin(ang)*dis);
   */
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