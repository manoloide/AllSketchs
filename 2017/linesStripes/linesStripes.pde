int seed = int(random(999999));

PShader post;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  //pixelDensity(2);
  post = loadShader("post.glsl");
  //generate();
}

void draw() {
  //if (frameCount%40 == 0) generate()
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    //generate();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {

  float time = millis()/1000.;
  background(140);

  randomSeed(seed);
  noiseSeed(seed);

  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);
  translate(width/2, height/2, 0);

  int sub = 180; 
  int div = 32;

  float da = PI/div;

  float ia = time*random(-1, 1);
  float ds = random(0.1)*random(1);
  float ic = random(1000)+time*random(20.2);
  float dc = random(100)*random(1);

  float minrad = width*random(0.4, 0.6);
  float maxrad = width*random(0.6, 0.8);
  noStroke();
  for (int i = 0; i < sub; i++) {
    float s1 = map(cos(ia+i*ds), -1, 1, minrad, maxrad);
    float s2 = map(cos(ia+(i+1)*ds), -1, 1, minrad, maxrad);
    float y1 = width*map(i, 0, sub, -0.4, 0.4);
    float y2 = width*map(i+1, 0, sub, -0.4, 0.4);
    fill(getColor(ic+dc*i));
    for (int j = 0; j < div; j++) {
      float a1 = da*j;
      float a2 = da*(j+1);
      beginShape();
      vertex(cos(a1)*s1, y1, sin(a1)*s1);
      vertex(cos(a2)*s1, y1, sin(a2)*s1);
      vertex(cos(a2)*s2, y2, sin(a2)*s2);
      vertex(cos(a1)*s2, y2, sin(a1)*s2);
      endShape(CLOSE);
    }
  }

  post = loadShader("post.glsl");
  post.set("resolution", float(width), float(height));
  post.set("time", time);
  filter(post);
}
//https://coolors.co/181a99-5d93cc-454593-e05328-e28976
//int colors[] = {#DB1136, #00B0BA, #3B0BE8, #FFE15B, #3D2C2E};
int colors[] = {#EAA104, #F9BBD1, #47A1BC, #EA2525};

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