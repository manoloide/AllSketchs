int seed = int(random(999999));

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));

  render();
}

void render() {

  //lights();
  noiseSeed(seed);
  randomSeed(seed);

  background(getColor(random(8)));

  float fov = PI/random(1.1, 3);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  translate(width/2, height/2, 0);
  rotateZ(random(TWO_PI));

  int size = 2048;
  int sub = int(random(8, 20));
  float h = random(80, 300);

  PGraphics texture = createGraphics(size, size);

  float sss = size*1.0/sub;
  texture.beginDraw();
  texture.stroke(0, 40);
  texture.noStroke();
  for (int j = 0; j < sub; j++) {
    for (int i = 0; i < sub; i++) {
      texture.fill(getColor(random(4)));
      texture.rect(i*sss, j*sss, sss, sss);
    }
  }

  //noStroke();
  texture.noStroke();
  for (int i = 0; i < pow(sub, 1.8); i++) {
    int x = int(random(sub));
    int y = int(random(sub));
    int s = int(random(1, 4));
    int sb = int(random(s, s*10));

    float s1 = sss*s;
    float s2 = s1*random(0.04, 0.3);
    noStroke();
    pushMatrix();
    translate(x*sss-size/2, 0, y*sss-size/2);
    colum(s1, s2, h, 80);
    popMatrix();

    texture.fill(255, 0, 0);
    texture.ellipse(x*sss, y*sss, sss*0.5, sss*0.5);

    for (int j = 0; j < sb; j++) {
      float ss = map(j, 0, sb, 1, 0)*s*sss;
      texture.fill(getColor(random(8)));
      texture.ellipse(x*sss, y*sss, ss, ss);
    }
  }
  texture.endDraw();

  imageMode(CENTER);
  pushMatrix();
  translate(0, -h, 0);
  rotateX(HALF_PI);
  image(texture, 0, 0);
  popMatrix();

  pushMatrix();
  translate(0, h, 0);
  rotateX(HALF_PI);
  image(texture, 0, 0);
  popMatrix();
} 

int colors[] = {#F05638, #F5C748, #3FD189, #FFB9DB, #AF8AB4, #6FC4EA, #FFFFFF, #412A50};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}


void colum(float s1, float s2, float h, int res) {
  int res1 = res;
  int res2 = res*2;
  for (int j = 0; j < res2; j++) {
    float h1 = map(j, 0, res2, -h, h);
    float h2 = map(j+1, 0, res2, -h, h);
    float r1 = map(abs(cos(map(j, 0, res2, -HALF_PI, HALF_PI))), 0, 1, s1, s2);
    float r2 = map(abs(cos(map(j+1, 0, res2, -HALF_PI, HALF_PI))), 0, 1, s1, s2);


    fill(getColor(random(8)));
    for (int i = 0; i < res1; i++) {
      float a1 = map(i, 0, res1, 0, TWO_PI);
      float a2 = map(i+1, 0, res1, 0, TWO_PI);

      float x1 = cos(a1)*r1;
      float z1 = sin(a1)*r1;

      float x2 = cos(a2)*r1;
      float z2 = sin(a2)*r1;

      float x3 = cos(a2)*r2;
      float z3 = sin(a2)*r2;

      float x4 = cos(a1)*r2;
      float z4 = sin(a1)*r2;
      beginShape();
      vertex(x1, h1, z1);
      vertex(x2, h1, z2);
      vertex(x3, h2, z3);
      vertex(x4, h2, z4);
      endShape(CLOSE);
    }
  }
}