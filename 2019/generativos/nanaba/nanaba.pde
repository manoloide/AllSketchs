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

  background(10);

  blendMode(ADD);

  desAng = random(1000);
  detAng = random(0.0002, 0.0003)*10;
  desAmp = random(1000);
  detAmp = random(0.0001, 0.0003)*4;
  desDes = random(1000);
  detDes = random(0.0002, 0.0003)*0.5;

  ArrayList<PVector> points = new ArrayList<PVector>();

  int cc = int(random(20, 30)*2);
  for (int i = 0; i < cc; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(30, 50)*0.8;

    x -= x%s;
    y -= y%s;

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      if (dist(x, y, other.x, other.y) < (s+other.z)*0.6) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  ArrayList<Triangle> triangles = Triangulate.triangulate(points);


  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);

    stroke(rcol(), random(60, 90));
    circleShadow(p.x, p.y, p.z, p.z*10.4);



    for (int j = 0; j < 3; j++) {
      stroke(rcol(), random(60, 90));
      float a1 = random(TAU);
      float a2 = a1+random(PI)*random(1);
      arcShadow(p.x, p.y, p.z, p.z*random(10, 40)*random(1), a1, a2);
    }
  }


  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);


    //fill(rcol(), 20);
    noFill();
    for (int k = 0; k < 20; k++) {
      PVector init = p.copy();

      beginShape();
      float ang = PI*1.5+random(-1, 1)*random(1);
      int c = int(random(50, random(60, 120)));
      int col = rcol();
      noStroke();
      for (int j = 0; j < c; j++) {
        float alp = pow(map(j, 0, c, 1, 0), 4)*180*0.3;
        float a = map(j, 0, c, PI*1.5, ang);
        //stroke(col, alp);
        fill(col, alp);
        PVector pp = def(init.x, init.y);
        vertex(pp.x, pp.y);
        init.x += cos(a)*2;
        init.y += sin(a)*2;
      }
      endShape();

      if (random(1) < 0.5) {
        noStroke();
        fill(rcol());
        float s = random(2, 4)*0.7;

        PVector pp = def(init.x, init.y);
        ellipse(pp.x, pp.y, s, s);
      }
    }
  }

  noFill();
  stroke(255, 220);

  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = triangles.get(i);
    if (random(1) < 0.3) ll(t.p1.x, t.p1.y, t.p2.x, t.p2.y);
  }
  /*
  beginShape(TRIANGLE);
   for (int i = 0; i < triangles.size(); i++) {
   Triangle t = triangles.get(i);
   int sel = int(random(3));
   fill(rcol(), (sel == 0)? random(80) : 0);
   vertex(t.p1.x, t.p1.y);
   fill(rcol(), (sel == 1)? random(80) : 0);
   vertex(t.p2.x, t.p2.y);
   fill(rcol(), (sel == 2)? random(80) : 0);
   vertex(t.p3.x, t.p3.y);
   }
   endShape(CLOSE);
   */

  /*
   noStroke();
   for (int i = 0; i < points.size(); i++) {
   PVector p = points.get(i);
   
   fill(255);
   ellipse(p.x, p.y, p.z, p.z);
   
   
   fill(rcol());
   ellipse(p.x, p.y, p.z*0.08, p.z*0.08);
   */
}

void ll(float x1, float y1, float x2, float y2) {
  float dis = dist(x1, y1, x2, y2);
  int cc = int(dis*0.2);
  //beginShape(LINE);
  for (int i = 0; i < cc; i++) {
    float v1 = map(i, 0, cc, 0, 1);
    float v2 = map(i+0.2, 0, cc, 0, 1);
    float nx1 = lerp(x1, x2, v1);
    float nx2 = lerp(x1, x2, v2);
    float ny1 = lerp(y1, y2, v1);
    float ny2 = lerp(y1, y2, v2);
    PVector p1 = def(nx1, ny1);
    PVector p2 = def(nx2, ny2);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  //endShape();
}


void circleShadow(float x, float y, float s1, float s2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;

  float area1 = PI*r1*r1;
  float area2 = PI*r2*r2;

  float sa = max(area1, area2)-min(area1, area2)*0.6;
  for (int i = 0; i < sa; i++) {
    float dis = lerp(r1, r2, random(1)*random(0.2, 1));
    float ang = random(TAU); 

    PVector p = def(x+cos(ang)*dis, y+sin(ang)*dis);

    point(p.x, p.y);
  }
}

void arcShadow(float x, float y, float s1, float s2, float a1, float a2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;

  float area1 = PI*r1*r1;
  float area2 = PI*r2*r2;

  float sa = max(area1, area2)-min(area1, area2);
  for (int i = 0; i < sa*0.1; i++) {
    float dis = lerp(r1, r2, random(1)*random(0.2, 1));
    float ang = lerp(a1, a2, random(1)); 

    PVector p = def(x+cos(ang)*dis, y+sin(ang)*dis);

    point(p.x, p.y);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}


//int colors[] = {#E1E8E0, #F5CE4B, #FC5801, #025DC4, #02201A, #489B4D};
//int colors[] = {#89EBFF, #8FFF3F, #EF2F00, #3DFF53, #FCD200};
//int colors[] = {#F0C7C0, #F65A5C, #3080E9, #50E2C6, #F7D3C3, #F41B9C};
//int colors[] = {#EF3621, #295166, #C9E81E, #0F190C, #F5FFFF};
//int colors[] = {#F5B4C4, #FCCE44, #EE723F, #77C9EC, #C5C4C4, #FFFFFF};
int colors[] = {#E2FAFF, #A4FF63, #EF7E62, #2B319B, #FCF4C9};
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
  return lerpColor(c1, c2, pow(v%1, 1));
}

float desAng = random(0.0001, 0.0003);
float detAng = random(0.0001, 0.0003);
float desAmp = random(0.0001, 0.0003);
float detAmp = random(0.0001, 0.0003);
float desDes = random(0.0001, 0.0003);
float detDes = random(0.0001, 0.0003);

PVector def(float x, float y) {
  float ang = (float)SimplexNoise.noise(desAng+x*detAng, desAng+y*detAng);
  float amp = (float)SimplexNoise.noise(desAmp+x*detAmp, desAmp+y*detAmp)*500;
  float des = (float)SimplexNoise.noise(desDes+x*detDes, desDes+y*detDes)*amp;
  return new PVector(x+cos(ang)*des, y+sin(ang)*des);
}
