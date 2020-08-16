import peasy.PeasyCam;

PeasyCam cam;
int seed = int(random(999999));
PShader post;

void setup() {
  size(1280, 720, P3D);
  smooth(8);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);

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

  background(20);
  
  float time = millis()*0.001;

  float fov = PI/random(1, 2);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  lights();
  perspective(fov, float(width)/float(height), 
    cameraZ/100.0, cameraZ*1000.0);
  translate(width/2, height/2);
  rotateX(random(-0.4, 0.4));
  rotateY(random(-0.4, 0.4));
  rotateZ(random(TAU));
  noStroke();
  for (int i = 0; i < 8000; i++) {
    float x = width*random(-1, 1)*2; 
    float y = width*random(-1, 1)*2;    
    float z = height*random(-1, 1)*2;
    
    x += time*random(1000);
    x = (x+width*2)%(width*4)-width*2;
    
    float w = width*random(0.2);
    float h = w*random(0.1);
    float d = h;;
    pushMatrix();
    translate(x, y, z);
    fill(rcol());
    box(w, h, d);
    popMatrix();
  }

  post = loadShader("post.glsl");
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

int colors[] = {#303a52, #574b90, #9e579d, #fc85ae};
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
