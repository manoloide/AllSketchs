import peasy.PeasyCam;

PeasyCam cam;

int seed = int(random(999999));
float det, des;
PShader post;

float SCALE = 0.8;
int swidth = 960;
int sheight = 540;




void settings() {
  size(int(swidth*SCALE), int(sheight*SCALE), P3D);
  smooth(4);
  pixelDensity(2);
}

void setup() {
  post = loadShader("post.glsl");
  cam = new PeasyCam(this, 400);
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 
  
  float time = millis()*random(0.1);

  randomSeed(seed);
  resetShader();
  background(0);

  noFill();
  stroke(255, 200);
  pushMatrix();
  float s = 16;
  float d = random(1, 3);
  float maxAng = random(0.8)*random(1);
  for (int i = 0; i < 12; i++) {
    line(-s, 0, 0, s, 0, 0);
    line(0, -s, 0, 0, s, 0);
    line(0, 0, -s, 0, 0, s);
    box(s*(1+cos(time*random(0.4))*0.1));
    rotateX(random(-maxAng, maxAng)*cos(time*random(0.2)));
    rotateY(random(-maxAng, maxAng)*cos(time*random(0.2)));
    rotateZ(random(-maxAng, maxAng)*cos(time*random(0.2)));
    translate(-d*s, 0, 0);
    s *= 0.8;
  }
  popMatrix();



  post = loadShader("post.glsl");
  //filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void arc3(float x1, float y1, float s1, float x2, float y2, float s2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = max(2, int(max(r1, r2)*PI));
  float da = TAU/cc;
  for (int i = 0; i < cc; i++) {
    float ang = da*i;
    beginShape();
    fill(col, alp1);
    vertex(x1+cos(ang)*r1, y1+sin(ang)*r1);
    vertex(x1+cos(ang+da)*r1, y1+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x2+cos(ang+da)*r2, y2+sin(ang+da)*r2);
    vertex(x2+cos(ang)*r2, y2+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void lineDashed(float x1, float y1, float x2, float y2, float jump, float amp) {
  float dir = atan2(y2-y1, x2-x1);
  float dis = dist(x1, y1, x2, y2);
  float desx = cos(dir);
  float desy = sin(dir);
  int cc = int(dis/jump);
  for (int i = 0; i < cc; i++) { 
    float r1 = (jump*(i));
    float r2 = (jump*(i+amp));
    line(x1+desx*r1, y1+desy*r1, x1+desx*r2, y1+desy*r2);
  }
}

int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
