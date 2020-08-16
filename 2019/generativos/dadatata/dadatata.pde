import toxi.math.noise.SimplexNoise;

//920141 48273 79839 883078 488833 773004
int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale  = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

void generate() {

  background(0);

  float fov = PI/random(1.6, 2.4);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);

  translate(width*0.5, height*0.5, random(-800));

  rotateX(random(TAU));
  rotateY(random(TAU));
  rotateZ(random(TAU));


  float radius = 1000;

  float detCol = random(0.001)*0.5;

  //sphere(radius*2);

  blendMode(ADD);
  for (int k = 0; k < 22000; k++) {
    int col = rcol();
    float r1 = random(10000);
    float x, y, z;
    x = y = z = 0;
    float dx, dy, dz;
    dx = dy = dz = 0;
    float alp = random(100, 200)*0.5;
    float noiCol = 0;
    float amp = 0;
    float maxAmp = random(100)*random(1);
    int cc = int(random(400));
    for (int i = 0; i < cc; i++) {
      float a1 = noise(i*0.0002, r1)*PI*1;
      float a2 = noise(k, i*0.0002)*PI*2;

      x = cos(a1)*cos(a2)*radius;
      y = sin(a1)*cos(a2)*radius;
      z = sin(a2)*radius;
      noiCol = (float) SimplexNoise.noise(detCol*x, detCol*y, detCol*z);
      col = getColor(noiCol*5);

      amp = cos(x)*sin(y)*tan(z)*maxAmp;

      dx = noise(noiCol*x)*amp;
      dy = noise(noiCol*y)*amp;
      dz = noise(noiCol*z)*amp;

      strokeWeight(map(i, 0, 1000, 1, 2));
      stroke(col, alp);
      point(x+dx, y+dy, z+dz);
    }


    if (random(1) < 0.1) {
      pushMatrix();
      translate(x+dx, y+dy, z+dz);
      noStroke();
      fill(col, 20);
      //ellipse(0, 0, 800, 800);
      noFill();
      stroke(col, random(200));
      float ss = random(20, 100);
      ellipse(0, 0, ss, ss);

      noStroke();
      fill(255, 140);
      ellipse(0, 0, 3, 3);
      popMatrix();
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(99999));
    generate();
  }
}

//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
//int colors[] = {#CAB18A, #C99A4E, #2D2A10};
int colors[] = {#F73B3B, #9DAAAB, #6789AA, #4F4873, #3A3A3A};
//int colors[] = {#4C8E58, #D00202, #F7D20D, #66B6CD};
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
  return lerpColor(c1, c2, pow(v%1, 2.8));
}

float random2 (float x, float y) {
  float d = x*12.9898+y*78.233;
  return (abs(sin(d)*43758.5453123))%1;
}


float noise2 (float x, float y) {
  float ix = floor(x);
  float iy = floor(y);
  float fx = x%1;
  float fy = y%1;

  // Four corners in 2D of a tile
  float a = random2(ix, iy);
  float b = random2(ix+1, iy);
  float c = random2(ix, iy+1);
  float d = random2(ix+1, iy+1);

  float ux = fx * fx * (3.0 - 2.0 * fx);
  float uy = fy * fy * (3.0 - 2.0 * fy);

  return lerp(a, b, ux) +
    (c - a)* uy * (1.0 - ux) +
    (d - b) * ux * uy;
}

float fbm (float x, float y) {
  int oct = 4;
  float val = 0.0;
  float amp = .5;
  for (int i = 0; i < oct; i++) {
    val += amp * noise2(x, y);
    x *= 2.;
    y *= 2.;
    amp *= .5;
  }
  return val;
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int res = int(max(2, (r1*r2)*PI*0.2));
  float da = (a2-a1)/res;
  //col = rcol();
  beginShape(QUAD_STRIP);
  for (int i = 0; i < res; i++) {
    float ang = a1+da*i;
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    fill(col, alp2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
  }
  endShape();
}
