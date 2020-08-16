 import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;
import peasy.PeasyCam;

//PeasyCam cam;

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
  //cam = new PeasyCam(this, 400);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'c') 
    background(0);
  else {
    seed = int(random(999999));
    generate();
  }
}

float time;
void generate() {

  hint(ENABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  time = (System.currentTimeMillis()%10000000)*0.0001;

  translate(width*0.5, height*0.5, -200);
  //rotateX(random(-1, 1)*random(0.6));
  //rotateY(random(-1, 1)*random(0.6));

  randomSeed(seed);
  noiseSeed(seed);

  background(0);

  blendMode(ADD);
  hint(DISABLE_DEPTH_TEST);

  ArrayList<PVector> points = new ArrayList<PVector>();
  float det = random(0.0016);
  for (int i = 0; i < 120000; i++) {
    float x = ((float) SimplexNoise.noise(i*det, time*det, i))*width*0.8;//random(-0.5, 0.5)*width;
    float y = ((float) SimplexNoise.noise(time*det, i, i*det))*height*0.8;
    float s = random(500)*random(0.5, 1);//*cos(time*0.02+i);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      float dis = dist(o.x, o.y, x, y);
      if (dis < (o.z+s)*0.6) {
        add = false; 
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }


  ArrayList<PVector> p2s = new ArrayList<PVector>();
  stroke(0, 180);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float s = p.z*1.2;//*0.6;
    //line(p.x, p.y, 0, p.x, p.y, s);
    //fill(getColor(s*s*PI*0.1));
    int cc = int(s/5);
    float dd = s*1./cc;
    int c1 = rcol();
    int c2 = rcol();
    for (int j = 0; j < cc; j++) {
      float amp = pow((cc-j)*1./cc, 2);
      pushMatrix();
      translate(0, 0, j*dd);
      if ((j%2) == 0) fill(c1, 20);
      else fill(c2, 20);
      //fill((j%2)*255, amp*255);
      ellipse(p.x, p.y, s*amp, s*amp);
      popMatrix();
    }
    p2s.add(new PVector(p.x, p.y, s));
  }


  ArrayList<Triangle> tris = Triangulate.triangulate(p2s);
  stroke(0, 20);
  noFill();
  noStroke();
  float detCol = random(0.0005, 0.002);

  beginShape(TRIANGLE);
  for (int i = 0; i < tris.size(); i++) {
    if (random(1) > 0.6) continue;
    Triangle t = tris.get(i);

    PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);
    //fill(rcol());
    //noStroke();
    //if (random(1) < 0.2) fill(rcol(), random(200));
    //else noFill();
    stroke(rcol());
    int col = getColor(noise(cen.x*detCol, cen.y*detCol)*10);
    fill(col, 140);
    vertex(t.p1.x, t.p1.y, t.p1.z);
    fill(col, random(180, 255));
    vertex(t.p2.x, t.p2.y, t.p2.z);
    fill(0, random(180, 255));
    vertex(t.p3.x, t.p3.y, t.p3.z);
  }
  endShape(CLOSE);

  //hint(DISABLE_DEPTH_TEST);

  noStroke();
  beginShape(QUAD);
  for (int i = 0; i < tris.size(); i++) {
    //if (random(1) > 0.9) continue;
    Triangle t = tris.get(i);
    int sub = 24;
    int col = rcol();
    for (int j = 0; j < sub; j++) {
      float v1 = j*1./sub;
      float v2 = (j+1)*1./sub;
      fill(col, 0);
      vertex(lerp(t.p1.x, t.p3.x, v1), lerp(t.p1.y, t.p3.y, v1), lerp(t.p1.z, t.p3.z, v1));
      vertex(lerp(t.p2.x, t.p3.x, v1), lerp(t.p2.y, t.p3.y, v1), lerp(t.p2.z, t.p3.z, v1));
      fill(col, 60);
      vertex(lerp(t.p2.x, t.p3.x, v2), lerp(t.p2.y, t.p3.y, v2), lerp(t.p2.z, t.p3.z, v2));
      vertex(lerp(t.p1.x, t.p3.x, v2), lerp(t.p1.y, t.p3.y, v2), lerp(t.p1.z, t.p3.z, v2));
    }
    col = rcol();
    for (int j = 0; j < sub; j++) {
      float v1 = j*1./sub;
      float v2 = (j+1)*1./sub; 
      fill(col, 20);
      vertex(lerp(t.p1.x, t.p2.x, v1), lerp(t.p1.y, t.p2.y, v1), lerp(t.p1.z, t.p2.z, v1));
      vertex(lerp(t.p3.x, t.p2.x, v1), lerp(t.p3.y, t.p2.y, v1), lerp(t.p3.z, t.p2.z, v1));
      fill(col, 0);
      vertex(lerp(t.p3.x, t.p2.x, v2), lerp(t.p3.y, t.p2.y, v2), lerp(t.p3.z, t.p2.z, v2));
      vertex(lerp(t.p1.x, t.p2.x, v2), lerp(t.p1.y, t.p2.y, v2), lerp(t.p1.z, t.p2.z, v2));
    }
  }
  endShape(CLOSE);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFB401, #072457, #EF4C02, #ADC7C8, #FE6567};
//int colors[] = {#07001C, #2e0091, #E2A218, #D61406};
//int colors[] = {#99002B, #EFA300, #CED1E2, #D66953, #28422E};
//int colors[] = {#99002B, #CED1E2, #D66953, #28422E};
int colors[] = {#EA2E73, #F7AA06, #1577D8};
//int colors[] = {#0F0F0F, #7C7C7C, #4C4C4C};
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
