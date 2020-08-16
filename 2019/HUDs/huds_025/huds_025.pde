import org.processing.wiki.triangulate.*;

int seed = int(random(999999));

float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  background(0);

  generate();

  if (export) {
    saveImage();
    exit();
  }
}

void draw() {
}

class Point {
  float x, y;
  int col;
  Point(float x, float y, int col) {
    this.x = x; 
    this.y = y;
    this.col = col;
  }
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


  hint(DISABLE_DEPTH_TEST);

  randomSeed(seed);
  noiseSeed(seed);

  background(lerpColor(#091B21, color(0), 0.4));
  ortho(-width/2, width/2, -height/2, height/2);

  translate(width*0.5, height*0.5);
  rotateX(PI*random(0.18, 0.32)*0.8);
  rotateZ(PI*random(0.3, 0.82)*0.8);

  int div = 11;
  float bb = 10;

  float size = width*1.6;
  float ss = (size-bb*2)/div;

  blendMode(ADD);
  noStroke();


  stroke(255, 20);
  for (int i = 0; i < div; i++) {
    float v = (i-div*0.5+0.5)*ss;
    line(v, -size*0.5, v, +size*0.5);
    line(-size*0.5, v, +size*0.5, v);
  }


  rectMode(CENTER);
  for (int j = 0; j < div; j++) {
    for (int i = 0; i < div; i++) {
      if (random(1) < 0.2) continue;
      float x = (i-div*0.5+0.5)*ss;
      float y = (j-div*0.5+0.5)*ss;
      fill(255, random(30));
      rect(x, y, ss*0.05, ss*0.05);
    }
  }



  noStroke();
  for (int j = 0; j < div; j++) {
    for (int i = 0; i < div; i++) {
      if (random(1) < 0.5) continue;
      float x = (i-div*0.5)*ss;
      float y = (j-div*0.5)*ss;
      float sss = random(ss*0.5)*random(1)*random(1);
      fill(255, random(20));
      rect(x, y, sss, sss);
    }
  }


  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int j = 0; j < div*10; j++) {
    for (int i = 0; i < div*10; i++) {
      if (random(1) < 0.2) continue;
      float x = (i-div*5)*ss*0.1;
      float y = (j-div*5)*ss*0.1;
      stroke(255, random(130));
      point(x, y);
      if (random(1) < 0.005) {
        noFill();
        stroke(255, 30);
        float sss = ss*0.1*random(0.2, 1);
        rect(x, y, sss, sss);
        points.add(new PVector(x, y));
      }
    }
  }


  ArrayList triangles = Triangulate.triangulate(points);

  noFill();
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.7) continue;
    Triangle t = (Triangle)triangles.get(i);
    stroke(255, random(40)); 

    noFill();
    if (random(1) < 0.2) fill(rcol(), random(30));

    vertex(t.p1.x, t.p1.y, t.p1.z);
    vertex(t.p2.x, t.p2.y, t.p2.z);
    vertex(t.p3.x, t.p3.y, t.p3.z);
  }
  endShape();

  noStroke();
  fill(255, 120);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    PVector c = (t.p1.copy().add(t.p2).add(t.p3)).div(3);
    ellipse(c.x, c.y, 2, 2);
  }

  ArrayList<PVector> torres = new ArrayList<PVector>();

  for (int j = 0; j < div; j++) {
    for (int i = 0; i < div; i++) {
      if (random(1) < 0.9) continue;
      float x = (i-div*0.5+0.5)*ss;
      float y = (j-div*0.5+0.5)*ss;
      pushMatrix();
      translate(x, y);
      //rect(0, 0, ss-2, ss-2);

      noFill();
      int str = rcol();
      stroke(str, random(255));
      ellipse(0, 0, ss*0.9, ss*0.9);

      //line(0, 0, 0, 0, 0, 300);

      int amp = int(random(1, 4)*2);
      stroke(str, random(255)*random(1));
      ellipse(0, 0, ss*amp, ss*amp);

      /*
      int cccc = int(random(-4, 2));
      for (int k = 0; k < cccc; k++) {
        dataArc(ss*amp);
      }
      */

      int pulses = int(random(-1, 8));
      for (int k = 0; k < pulses; k++) {
        float sss = random(1, 8);
        float ang = random(TAU);
        float rad = (ss*amp-sss)*sqrt(random(1))*0.5;
        float xx = cos(ang)*rad;
        float yy = sin(ang)*rad;
        float ss2 = sss*random(0.2, 0.6);
        if (random(1) < 0.5) {
          stroke(str, random(220));
          noFill();
          ellipse(xx, yy, sss, sss);

          fill(str, random(200, 240));
          noStroke();
          ellipse(xx, yy, ss2*0.6, ss2*0.6);
        } else {
          fill(str, random(200, 240));
          noStroke();
          ellipse(xx, yy, ss2, ss2);
        }
      }


      noStroke();
      if (random(1) < 0.8) {
        stroke(200, 1);
        arc2(0, 0, ss*amp, ss*amp*0.8, 0, TAU, rcol(), random(40)*random(1), 0);
        noStroke();
      }
      if (random(1) < 0.5) {
        fill(rcol(), random(30));
        ellipse(0, 0, ss*0.8, ss*0.8);
      }
      noStroke();
      fill(rcol(), random(120));
      ellipse(0, 0, ss*0.05, ss*0.05);

      float h = random(300)*random(1);

      circles(ss*random(0.2, 0.6)-4, h, int(random(32)));
      popMatrix();

      torres.add(new PVector(x, y, h));
    }
  }

  triangles = Triangulate.triangulate(torres);

  // draw the mesh of triangles
  stroke(0, 40);
  fill(255, 40);
  noFill();
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    stroke(rcol(), random(60));
    vertex(t.p1.x, t.p1.y, t.p1.z);
    vertex(t.p2.x, t.p2.y, t.p2.z);
    vertex(t.p3.x, t.p3.y, t.p3.z);
  }
  endShape();


  for (int i = 0; i < torres.size(); i++) {
    PVector t = torres.get(i);
    stroke(rcol(), random(200)*random(1));
    line(t.x, t.y, 0, t.x, t.y, t.z);
  }

  blendMode(NORMAL);
}

void dataArc(float s) {
  float r = s*0.5;
  float a1 = random(TAU);
  float a2 = a1+random(HALF_PI)*0.5;

  float r1 = random(r*0.1, r);
  float r2 = r1-r*random(0.01, 0.05)*0.4;
  
  noStroke();
  float alp = random(180);
  arc2(0, 0, r1, r2, a1, a2, rcol(), alp, alp);
}

void circles(float maxRad, float h, int cc) {

  float detRad = random(10.1)*random(1);
  float desRad = random(1000);

  float ang = random(TAU);

  for (int i = 0; i < cc; i++) {
    float y = random(2, h)*random(0.5, 1)*random(1);
    float r = (0.1+noise(desRad+y*detRad)*0.9)*maxRad;//width*random(0.05, 0.4)*random(0.4, 1);
    int sub = int(random(12, random(60, 160)*random(0.8, 1)));
    float da = TAU/sub;
    stroke(rcol(), random(80, 250));
    pushMatrix();
    translate(0, 0, y);
    point(0, 0, 0);
    for (int j = 0; j < sub; j++) {
      float a = ang+da*j;
      point(cos(a)*r, sin(a)*r);
    }
    popMatrix();
  }
}



void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int cc = (int) max(4, PI*pow(max(s1, s2)*0.1, 1)*3);

  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang1 = map(i+0, 0, cc, a1, a2); 
    float ang2 = map(i+1, 0, cc, a1, a2);
    fill(col, alp1);
    vertex(x+cos(ang1)*r1, y+sin(ang1)*r1);
    vertex(x+cos(ang2)*r1, y+sin(ang2)*r1);
    fill(col, alp2);
    vertex(x+cos(ang2)*r2, y+sin(ang2)*r2);
    vertex(x+cos(ang1)*r2, y+sin(ang1)*r2);
  }
  endShape();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#43748e, #ffc301, #FFE6D8, #F399AB};
//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
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
