int seed = int(random(999999));
float det, des;
PShader post;

float SCALE = 1;
int swidth = 960;
int sheight = 960;

void settings() {
  size(int(swidth*SCALE), int(sheight*SCALE), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {
  post = loadShader("post.glsl");
  generate();
}

void draw() {
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

  randomSeed(seed);
  resetShader();
  background(240);

  translate(width*random(0.2, 0.8), height*random(0.2, 0.8));


  ambientLight(255, 255, 255);
  noStroke();
  int cc = int(random(150, 190));
  for (int i = 0; i < cc; i++) {
    pushMatrix();
    fill(0);
    translate(random(-500, 500), random(-500, 500), random(-500, 500));
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));
    noStroke();
    box(80);
    stroke(0);
    float len = 120;
    for (float k = -len; k < len; k+=10) {
      float amp = 2*(1-cos(k)*0.1);
      line(k, +amp, 0, k, 0, 0);
      line(k, -amp, 0, k, 0, 0);
      line(k, 0, +amp, k, 0, 0);
      line(k, 0, -amp, k, 0, 0);
    }
    line(-len, 0, 0, len, 0, 0);
    line(0, -len, 0, 0, len, 0);
    line(0, 0, -len, 0, 0, len);
    popMatrix();
  }

  noStroke();
  for (int i = 0; i < 800; i++) {
    pushMatrix();
    fill((random(1) < 0.5)?0:240);
    translate(random(-500, 500), random(-500, 500), random(-500, 500));
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));
    box(10);
    popMatrix();
  }

  for (int i = 0; i < 1200; i++) {
    pushMatrix();
    fill((random(1) < 0.5)?0:240);
    translate(random(-500, 500), random(-500, 500), random(-500, 500));
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));
    box(2);
    popMatrix();
  }

  post = loadShader("post.glsl");
  post.set("seed", float(seed));
  filter(post);
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
