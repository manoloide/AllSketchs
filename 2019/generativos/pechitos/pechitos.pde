import org.processing.wiki.triangulate.*;


int seed = 219798;//int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(2);
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

  println("seed:", seed);

  randomSeed(seed);
  noiseSeed(seed);
  background(lerpColor(#1D1D1D, color(0), 0.2));


  scale(scale);

  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 180; i++) {
    float x = swidth*random(-0.2, 1.2);
    float y = sheight*random(-0.2, 1.2);

    x -= x%6;
    y -= y%6;

    float s = swidth*random(0.3);

    boolean add = true;

    for (int j = 0; j < points.size(); j++) {
      PVector other = points.get(j);
      float dis = dist(x, y, other.x, other.y);

      if (dis < (s+other.z)*0.2) {
        add = false;
        i--;
        break;
      }
    }

    if (add) {
      points.add(new PVector(x, y, s));
    }
  }

  for (int i = 0; i < 12; i++) {
    PVector p1 = points.get(int(random(points.size())));
    PVector p2 = points.get(int(random(points.size())));
    PVector p3 = points.get(int(random(points.size()))); 
    int col1 = rcol();
    int col2 = rcol();

    float dx = int(random(-10, 10))*6;
    float dy = int(random(-10, 10))*6;



    /*
    ArrayList tris = trisInTris(p1, p2, p3, 100);

    int col = rcol();
    stroke(255, 4);
    beginShape(TRIANGLES);
    for (int j = 0; j < tris.size(); j++) {
      Triangle t = (Triangle) tris.get(j);
      fill(col, 0);
      vertex(t.p1.x, t.p1.y);
      fill(col, 30);
      vertex(t.p2.x, t.p2.y);
      vertex(t.p3.x, t.p3.y);
    }
    endShape();
    */


    noStroke();
    beginShape(TRIANGLES);
    /*
    fill(col2, 0);
     vertex(p1.x+dx, p1.y+dy);
     fill(col2, random(120, 160)*random(0.5, 1));
     vertex(p2.x+dx, p2.y+dy);
     vertex(p3.x+dx, p3.y+dy);
     */

    fill(col1, 0);
    vertex(p1.x, p1.y);
    fill(col1, random(120, 160)*random(0.5, 1));
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);

    endShape();

    PVector p = inTri(p1, p2, p3, 0.5, 0.5);
    float area = ((p2.x-p1.x)*(p3.y-p1.y)-(p3.x-p1.x)*(p2.y-p1.y))*0.5;
    float s = area*0.001*random(0.5, 1)*random(1);

    int cornea = rcol();

    arc2(p.x, p.y, s, s*1.6, 0, TAU, cornea, 50, 0);

    fill(255);
    ellipse(p.x, p.y, s, s);
    noStroke();
    arc2(p.x, p.y, s*0.92, s, 0, TAU, color(0), 20, 0);
    float ss = s*random(0.5, 0.9);
    fill(cornea);
    ellipse(p.x, p.y, ss, ss);
    arc2(p.x, p.y, ss*0.9, ss, 0, TAU, color(0), 0, 50);
    fill(10);
    ellipse(p.x, p.y, ss*0.9, ss*0.9);
    stroke(255, 20);
    //arc2(p.x, p.y, ss*0.9, ss*0.94, 0, TAU, color(0), 0, 0);
  }

  stroke(0, 6);
  //fill(255, 40);
  beginShape(TRIANGLES);
  ArrayList triangles = Triangulate.triangulate(points);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(rcol(), random(20, 28));
    vertex(t.p1.x, t.p1.y);
    fill(rcol(), 0);
    vertex(t.p2.x, t.p2.y);
    fill(rcol(), 0);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  ArrayList<PVector> points2 = new ArrayList<PVector>();
  float des = random(1000);
  float det = random(0.1);

  float desAng = random(1000);
  float detAng = random(0.002);

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float s = p.z*random(1);
    float a = noise(desAng+p.x*detAng, desAng+p.y*detAng)*2*TAU;
    stroke(255, 20);
    float lx = p.x+cos(a)*s*0.5;
    float ly = p.y+sin(a)*s*0.5;
    points2.add(new PVector(lx, ly));
    line(p.x, p.y, lx, ly);
    ellipse(lx, ly, 3, 3);
    noStroke();
    fill(200, random(2, 14));
    ellipse(p.x, p.y, s, s);
    int col = rcol();
    fill(col, 20);
    ellipse(p.x, p.y, p.z*0.12, p.z*0.12);
    fill(lerpColor(col, color(0), random(0.2)));
    ellipse(p.x, p.y, p.z*0.04, p.z*0.04);
  }

  /*
  noFill();
   stroke(255);
   beginShape(TRIANGLES);
   triangles = Triangulate.triangulate(points2);
   for (int i = 0; i < triangles.size(); i++) {
   Triangle t = (Triangle)triangles.get(i);
   stroke(getColor(noise(des+t.p1.x*det, des+t.p1.y*det)*colors.length), 50);
   vertex(t.p1.x, t.p1.y);
   stroke(getColor(noise(des+t.p2.x*det, des+t.p2.y*det)*colors.length), 50);
   vertex(t.p2.x, t.p2.y);
   stroke(getColor(noise(des+t.p3.x*det, des+t.p3.y*det)*colors.length), 50);
   vertex(t.p3.x, t.p3.y);
   }
   endShape();
   */
}

ArrayList trisInTris(PVector p1, PVector p2, PVector p3, int subs) {

  ArrayList tris = new ArrayList();

  tris.add(new Triangle(p1.copy(), p2.copy(), p3.copy()));

  for (int i = 0; i < subs; i++) {
    int ind = int(random(tris.size()));
    Triangle t = (Triangle) tris.get(ind);

    //float l1 = t.p1.dist(t.p2);
    //float l2 = t.p2.dist(t.p3);
    //float l3 = t.p3.dist(t.p1);

    PVector ap1 = t.p1.copy();
    PVector ap2 = t.p2.copy();
    PVector ap3 = t.p3.copy();

    PVector m12 = ap1.copy().lerp(ap2, random(0.4, 0.6));
    PVector m23 = ap2.copy().lerp(ap3, random(0.4, 0.6));
    PVector m31 = ap3.copy().lerp(ap1, random(0.4, 0.6));

    tris.add(new Triangle(m12, m23, m31));
    tris.add(new Triangle(m12, ap1, m31));
    tris.add(new Triangle(m12, m23, ap2));
    tris.add(new Triangle(ap3, m23, m31));
    /*
    PVector np = inTri(t.p1, t.p2, t.p3, random(0.4, 0.6), random(0.4, 0.6));
     tris.add(new Triangle(t.p1, t.p2, np));
     tris.add(new Triangle(t.p2, t.p3, np));
     tris.add(new Triangle(t.p3, t.p1, np));
     */

    tris.remove(ind);
  }

  return tris;
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;

  float seg = max(8, abs(a2-a1)*pow(max(r1, r2), 2)*0.25);

  float da = (a2-a1)/seg;

  beginShape(QUADS);
  for (int i = 0; i < seg; i++) {
    float ang1 = a1+da*i;
    float ang2 = a2+da*(i+1);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape(CLOSE);
}

PVector randInTri(PVector p1, PVector p2, PVector p3) {
  return inTri(p1, p2, p3, random(1), random(1));
}

PVector inTri(PVector p1, PVector p2, PVector p3, float r1, float r2) {
  float s1 = sqrt(r1); 
  float x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1; 
  float y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1; 
  return new PVector(x, y);
}


void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
int colors[] = {#2884BC, #2640FB, #FC88CF, #E9D202, #61B9E1, #42579F, #EF4E37};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
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
  return lerpColor(c1, c2, pow(v%1, 2));
}
