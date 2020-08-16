import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

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

  generate();
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

  randomSeed(seed);
  noiseSeed(seed);
  //background(252, 250, 245);
  background(rcol());

  float fov = PI/1.14;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
    cameraZ/10.0, cameraZ*10.0);


  float size = width*2.0;

  noFill();
  stroke(255, 220);
  noStroke();
  float rot = random(0.45);


  pushMatrix();
  translate(width*0.5, height*0.5);
  rotateX(random(-rot, rot));
  rotateY(random(-rot, rot));
  rotateZ(random(-rot, rot)*4);

  //box(width*1.0);
  beginShape(QUADS);
  /*
  fill(rcol(), random(255));
   vertex(-size*0.5, -size*0.5, -size*0.5);
   vertex(+size*0.5, -size*0.5, -size*0.5);
   vertex(+size*0.5, +size*0.5, -size*0.5);
   vertex(-size*0.5, +size*0.5, -size*0.5);
   */

  fill(rcol(), random(random(255), 255));
  vertex(-size*0.5, +size*0.5, -size*0.5);
  vertex(+size*0.5, +size*0.5, -size*0.5);
  fill(rcol(), 0);
  vertex(+size*0.5, +size*0.5, +size*0.5);
  vertex(-size*0.5, +size*0.5, +size*0.5);

  fill(rcol(), random(random(255), 255));
  vertex(-size*0.5, -size*0.5, -size*0.5);
  vertex(+size*0.5, -size*0.5, -size*0.5);
  fill(rcol(), 0);
  vertex(+size*0.5, -size*0.5, +size*0.5);
  vertex(-size*0.5, -size*0.5, +size*0.5);

  fill(rcol(), random(random(255), 255));
  vertex(-size*0.5, -size*0.5, -size*0.5);
  vertex(-size*0.5, +size*0.5, -size*0.5);
  fill(rcol(), 0);
  vertex(-size*0.5, +size*0.5, +size*0.5);
  vertex(-size*0.5, -size*0.5, +size*0.5);

  fill(rcol(), random(random(255), 255));
  vertex(+size*0.5, -size*0.5, -size*0.5);
  vertex(+size*0.5, +size*0.5, -size*0.5);
  fill(rcol(), 0);
  vertex(+size*0.5, +size*0.5, +size*0.5);
  vertex(+size*0.5, -size*0.5, +size*0.5);

  endShape();

  float det1 = random(0.002)*0.4;
  float det2 = random(0.002)*0.4;
  float det3 = random(0.002)*0.4;
  float amp1 = random(60);
  float amp2 = random(10);
  float amp3 = random(30);

  float ss = size*0.5;

  float m1 = random(0.5, 1.5);
  float m2 = random(0.5, 1.5);

  for (int k = 0; k < 2; k++) {
    beginShape(POINTS);
    for (int i = 0; i < 400000; i++) {
      float a1 = random(TAU); 
      float a2 = random(PI);

      float amp = 0.7;//sqrt(random(1));

      float x = cos(a1)*cos(a2)*amp*ss;
      float y = sin(a1)*cos(a2)*amp*ss;
      float z = sin(a2)*amp*ss;

      PVector p = def(x, y, z, det1, amp1);
      p = def(p.x, p.y, p.z, det2, amp2);
      p = def(p.x, p.y, p.z, det3, amp3);
      p = def(p.x, p.y, p.z, det2, amp3);

      stroke(getColor(a1*m2+a2*m1), random(200, 255));
      vertex(p.x, p.y, p.z);
    }
    endShape();
  }

  popMatrix();

  /*
  float cx = width*0.5; 
   float cy = height*0.5;
   for (int i = 0; i < 20; i++) {
   float v = i/20.0;
   float s = width*(pow(1-v, 3));
   fill(getColor(v*5));
   ellipse(cx, cy, s, s);
   }
   */
}

PVector def(float x, float y, float z, float det, float amp) {
  float a1 = (float)SimplexNoise.noise(x*det, y*det, z*det)*PI; 
  float a2 = (float)SimplexNoise.noise(x*det, y*det, z*det)*TAU; 

  float na = (float)SimplexNoise.noise(z*det, x*det, z*det)*200;

  return new PVector(x+cos(a1)*sin(a2)*na, y+sin(a1)*sin(a2)*na, z+cos(a2)*na);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
int colors[] = {#382F30, #B11D1B, #EDDCE2, #E46517};
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
  return lerpColor(c1, c2, pow(v%1, 0.6));
} 
