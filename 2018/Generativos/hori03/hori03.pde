int seed = int(random(999999));

PShader post;

float SCALE = 1;
float swidth, sheight;

void settings() {
  swidth = 960;
  sheight = 560;
  size(int(swidth*SCALE), int(sheight*SCALE), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  post = loadShader("post.glsl");
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
  
  float time = millis()*0.001;

  scale(SCALE);

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());
  translate(width/2, height/2, -200);
  scale(1+noise(time*random(0.2)));
  rotateX(noise(time*random(0.3)*random(0.2)-0.1, 20));
  rotateY(noise(time*random(0.3)*random(0.2)-0.1, 10));
  rotateZ(noise(time*random(0.3)*random(0.2)-0.1, 50));

  noStroke();
  int cc = int(random(200)*random(0.2, 1));
  translate(-width/2, -height/2);
  for (int i = 0; i < cc; i++) {
    float h = swidth*random(1)*random(0.14);
    float y = random(swidth);
    //int col = lerpColor(rcol(), getColor(), random(1)*random(0.2, 1));
    int sub = int(random(120));
    float ss = swidth*1./sub;
    float dc1 = random(100)*random(1)+time*random(-1, 1)*random(0.1);
    float dc2 = random(100)*random(1)+time*random(-1, 1)*random(0.1);
    float des = random(1000)+time*random(-0.1, 0.1);
    float det = random(0.06);
    float amp = h*random(10);
    for (int j = 0; j < sub; j++) {
      //fill(lerpColor(col, getColor(), random(1)));
      //rect(ss*j, y, ss, h);
      float d1 = noise(des+j*det)*amp;
      float d2 = noise(des+(j+1)*det)*amp;
      beginShape();
      fill(getColor(dc1*(j+i)));
      vertex(ss*(j+0), y, d1);
      vertex(ss*(j+1), y, d2);
      fill(getColor(dc2*(j+i)));
      vertex(ss*(j+1), y+h, d2);
      vertex(ss*(j+0), y+h, d1);
      endShape(CLOSE);
    }
  }
  filter(post);
}



void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#1D1923, #BBC0AC, #5A8590, #C3A651, #8C3503};
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
