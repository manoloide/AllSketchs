import org.processing.wiki.triangulate.*;
import toxi.math.noise.SimplexNoise;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
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

  /*
  if (frameCount%120 == 0) {
   seed = int(random(999999));
   generate();
   }
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  blendMode(ADD);
  randomSeed(seed);
  noiseSeed(seed);
  background(0);
  //translate(width*0.5, height*0.5);

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 50; i++) {
    float x = width*random(-1, 2);
    float y = height*random(-1, 2);
    float s = width*random(0.1);
    points.add(new PVector(x, y, s));
  }

  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 400; j++) {
      PVector p = points.get(i);
      float ang = random(TAU);
      float dis = p.z*random(random(1), random(1, random((30))));
      float x = p.x+cos(ang)*dis;
      float y = p.y+sin(ang)*dis;
      float s = p.z*0.05;
      points.add(new PVector(x, y, s));
    }
  }

  ArrayList<Triangle> tris = Triangulate.triangulate(points);
  beginShape(TRIANGLE);
  stroke(255, 4);
  for (int i = 0; i < tris.size(); i++) {
    int val = int(random(3));
    Triangle t = tris.get(i);
    fill(255, 0);
    if (val == 0) fill(255, random(80));
    vertex(t.p1.x, t.p1.y);
    fill(255, 0);
    if (val == 1) fill(255, random(80));
    vertex(t.p2.x, t.p2.y);
    fill(255, 0);
    if (val == 2) fill(255, random(120));
    vertex(t.p3.x, t.p3.y);
  }

  noStroke();
  fill(255, 60, 140);
  for (int i = 0; i < tris.size(); i++) {
    if (random(1) > 0.03) continue;
    int val = int(random(3));
    Triangle t = tris.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  /*
  for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   float x = p.x;
   float y = p.y;
   float s = p.z;
   noStroke();
   fill(255, 50);
   ellipse(x, y, s, s);
   fill(0);
   ellipse(x, y, s*0.5, s*0.5);
   fill(255, 50);
   ellipse(x, y, s*0.05, s*0.05);
   stroke(255, 50);
   noFill();
   ellipse(x, y, s*0.05, s*0.05);
   }
   */
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//https://coolors.co/f76fc1-ff9129-afe36b-29a8cc-100082

//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#F76FC1, #FF7028, #AFE36B, #29a8cc, #100082}; //
//int colors[] = {#EAE5E5, #F7EB04, #7332AD, #000000, #92A7D3};
//int colors[] = {#333A95, #FFDC15, #FC9CE6, #31F5C2, #1E9BF3};
//int colors[] = {#333A95, #F6C806, #F789CA, #1E9BF3};
//int colors[] = {#f296a4, #3c53e8, #A1E569, #4ce7ff, #F4F4F4};
//int colors[] = {#F7B296, #374BD3, #9BEA5B, #E1F78A, #F4F4F4};
//int colors[] = {#E8A1B3, #F3C1CD, #E5D4DE, #D3D9E5, #AFBDDD, #A38BC5, #83778B, #29253B};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.1));
}
