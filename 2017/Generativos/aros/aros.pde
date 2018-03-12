int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else seed = int(random(9999999));
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  lights();
  background(0);

  randomSeed(seed);
  det = random(0.01);
  translate(width*0.5, height*0.5, 0);
  float time = millis()*0.001;
  for (int i = 0; i < 1; i++) {
    rotateX(time*random(-0.1, 0.1));
    rotateY(time*random(-0.1, 0.1));
    rotateZ(time*random(-0.1, 0.1));

    stroke(255);
    aro(width*random(0.4, 0.8), width*random(0.04, 0.1), width*random(0.008, 0.012));
  }
}

float det = random(0.1);
void aro(float s, float h, float g) {
  float r1 = s*0.5;
  float r2 = r1-g;
  int res = 128;
  float da = TWO_PI/res;
  int sub = 16;
  h *= 0.5;
  //beginShape();
  noStroke();
  for (int i = 0; i < res; i++) {
    float a1 = da*i;
    float a2 = a1+da;
    float x1 = cos(a1); 
    float y1 = sin(a1);
    float x2 = cos(a2); 
    float y2 = sin(a2);

    float hh = h/sub;
    for (int j = 0; j < sub; j++) {
      float h1 = -h+hh*j;
      float h2 = h1+hh;
      beginShape();
      vert(x1*r1, y1*r1, h1);
      vert(x2*r1, y2*r1, h1);
      vert(x2*r1, y2*r1, h2);
      vert(x1*r1, y1*r1, h2);
      endShape(CLOSE);

      beginShape();
      vert(x1*r2, y1*r2, h1);
      vert(x2*r2, y2*r2, h1);
      vert(x2*r2, y2*r2, h2);
      vert(x1*r2, y1*r2, h2);
      endShape(CLOSE);

      beginShape();
      vert(x1*r2, y1*r2, h1);
      vert(x2*r2, y2*r2, h1);
      vert(x2*r1, y2*r1, h1);
      vert(x1*r1, y1*r1, h1);
      endShape(CLOSE);

      beginShape();
      vert(x1*r2, y1*r2, h2);
      vert(x2*r2, y2*r2, h2);
      vert(x2*r1, y2*r1, h2);
      vert(x1*r1, y1*r1, h2);
      endShape(CLOSE);
    }

    //line(x1*r, y1*r, h, x2*r, y2*r, h);
  }
  //endShape(CLOSE);
}

void vert(float x, float y, float z) {    
  fill(getColor(noise(x*det, y*det, z*det)*colors.length*2));
  vertex(x, y, z);
}

//https://coolors.co/ffffff-09080c-d1370c-094c22-c997a7
int colors[] = {#ffffff, #09080c, #d1370c, #094c22, #c997a7};

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