import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  720;
float nheight = 720;
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

  //generate();
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

  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);
  //background(#CF2B06);
  background(#131C26);


  float horizon = height*0.6;

  //sky(horizon);

  rectMode(CENTER);
  for (int i = 0; i < 2; i++) {
    float v = random(1);
    float x = random(width);
    float y = height*lerp(0.5, 1, v);
    float w = 50*v;

    fill(rcol());
    rect(x, y, w, w);

    float y2 = lerp(height-y, height*0.5, v*0.8);
    float size = 450*v;

    fill(rcol());
    //rect(x, y2, size, size);
    fill(rcol());
    //ellipse(x, y2, size, size);


    ArrayList<PVector> points = new ArrayList<PVector>();

    fill(rcol());
    for (int k = 0; k < 40; k++) {
      float ang = random(TAU);
      float dis = random(random(random(1)), 1)*0.5;//acos(random(1))*0.25;
      float xx = x+cos(ang)*size*dis;
      float yy = y2+sin(ang)*size*dis;
      points.add(new PVector(xx, yy));
    }

    ArrayList<Triangle> tris = Triangulate.triangulate(points);
    ArrayList<PVector> npoints = new ArrayList<PVector>();
    beginShape(TRIANGLES);
    for (int t = 0; t < tris.size(); t++) {
      Triangle tri = tris.get(t);
      fill(rcol(), random(200));
      vertex(tri.p1.x, tri.p1.y);
      fill(rcol(), random(200));
      vertex(tri.p2.x, tri.p2.y);
      fill(rcol(), random(200));
      vertex(tri.p3.x, tri.p3.y);

      npoints.add(tri.p1.copy().add(tri.p2.copy()).add(tri.p3.copy()).div(3));
    }
    endShape();


    for (int k = 0; k < points.size(); k++) {
      PVector p = points.get(k);
      
      float min = 1000;
      PVector o = new PVector();
      for (int j = 0; j < npoints.size(); j++) {
        PVector a = npoints.get(j);
        float dis = dist(p.x, p.y, o.x, o.y);
        if (dis < min) {
          o = a.copy();
          min = dis;
        }
      }
      
      //o.x = lerp(p.x, o.x, 0.1);
      //o.y = lerp(p.y, o.y, 0.1);


      stroke(0, 50);
      line(p.x, p.y, o.x, o.y);
      noStroke();
      //ellipse(p.x, p.y, v*6, v*6);

      ellipse(o.x, o.y, 5, 5);
    }


    for (int k = 0; k < npoints.size(); k++) {
      PVector p = npoints.get(k);
    }
  }
}

PVector def(float x, float y, float z, float det, float amp) {
  double a1 = SimplexNoise.noise(x*det, y*det, z*det+seed*0.02)*TAU*2; 
  double a2 = SimplexNoise.noise(x*det, y*det+seed*0.02, z*det)*TAU*2; 
  float a = (float) SimplexNoise.noise(z*det, y*det, x*det+seed*0.02)*amp; 
  return new PVector((float)(x+Math.cos(a1)*Math.cos(a2)*a), (float)(y+Math.sin(a1)*Math.cos(a2)*amp), (float)(z+Math.sin(a2)*a));
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2); 
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#021408, #375585, #9FBF96, #1D551B, #E6C5CD};
//int colors[] = {#B25DF5, #004CDD, #F8E8F1};
//int colors[] = {#21CFF2, #003BBB, #F6E9F1, #F994F3};
//int colors[] = {#7C61FF, #0527FF, #F6F0FC, #E5D1FE};
//int colors[] = {#18002E, #001DDB, #E5D1FE, #F6F0FC, #E51C06};
//int colors[] = {#18002E, #001BCC, #E6D4FC, #F5F2F8, #E73504};
//int colors[] = {#060606, #534A3B, #6A4224, #AC7849, #EEE7DE};
int colors[] = {#FFFFFF, #FFB0D0, #F7DE20, #245C0E, #EB6117, #F72C11, #C6356B, #953DC4, #003399, #02060D}; 
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
