import org.processing.wiki.triangulate.*;

int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

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

void generate() {
  randomSeed(seed);



  randomSeed(seed);
  background(#61C2C9);

  noStroke();
  fill(255, 10);
  grid(160, 10);
  stroke(255, 20);
  noFill();
  strokeWeight(1);
  grid(40, 3);
  back1();

  stroke(255, 8);
  arc2(width*0.5, height*0.5, width*0.8, width*1.45, 0, TAU, color(#9AE32E), 80, 0);
  noStroke();
  arc2(width*0.5, height*0.5, width*0.804, width*0.9, 0, TAU, color(255), 40, 0);

  noStroke();
  fill(#9AE32E);
  rects(40, 2);


  stroke(255, 90);
  circle(width*0.5, height*0.5, width*0.404, width*0.405, 256, 9);
  circle(width*0.5, height*0.5, width*0.404, width*0.41, 64, 9);


  ArrayList<PVector> points = createPoints();


  borderCircles(points);
  circles(points);
}

void borderCircles(ArrayList<PVector> points) {


  FloatList angles = new FloatList();

  float cx = width*0.5;
  float cy = height*0.5;
  float ss = width*0.4;
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float ang = atan2(p.y-cy, p.x-cx);
    angles.push(ang);
    float nx = cx+cos(ang)*ss;
    float ny = cy+sin(ang)*ss;
    stroke(255, 40);
    line(nx, ny, p.x, p.y);
    noStroke();
    stroke(255);
    ellipse(nx, ny, 4, 4);
  }

  angles.sort();

  for (int i = 0; i < angles.size(); i++) {
    float ang = angles.get(i);
    float dx = cos(ang);
    float dy = sin(ang);
    stroke(255, 40);
    line(cx+dx*ss, cy+dy*ss, cx+dx*ss*1.05, cy+dy*ss*1.05);
  }

  stroke(255, 2);
  for (int i = 0; i < angles.size(); i++) {
    float a1 = angles.get(i+0);
    float a2 = angles.get((i+1)%angles.size());
    if(a1 > a2){
      a2 += TAU;
    }
    arc3(cx, cy, ss*2.01, ss*2.05, a1, a2, color(255), +60, -60);
    arc3(cx, cy, ss*2.01, ss*2.05, a1, a2, color(255), -60, +60);
    
    if(random(1) < 0.5)
      arc3(cx, cy, ss*2.11, ss*2.1, a1, a2, color(#9AE32E), +220, -60);
    else 
      arc3(cx, cy, ss*2.11, ss*2.1, a1, a2, color(#9AE32E), -60, +220);
    
  }
}

void circles(ArrayList<PVector> points) {

  ArrayList triangles = Triangulate.triangulate(points);
  stroke(255, 10);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    int col = color(255);
    float alp = 70;
    if (random(1) < 0.16) {
      col = color(#9AE32E);
      alp = 180;
    }
    Triangle t = (Triangle)triangles.get(i);
    fill(col, random(alp));
    vertex(t.p1.x, t.p1.y);
    fill(col, random(alp));
    vertex(t.p2.x, t.p2.y);
    fill(col, random(alp));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float x = p.x;
    float y = p.y;
    float s = p.z;


    int cc = int(random(5, 17));
    if (random(1) < 0.2) cc = 0;
    float da = TAU/cc;
    float r = random(0.7, 1.0);
    float a = random(TAU);
    strokeWeight(0.8);
    for (int j = 0; j < cc; j++) {
      float ang = a+da*j;
      stroke(255, 80);
      line(x, y, x+cos(ang)*r*s, y+sin(ang)*r*s);
      noStroke();
      float xx = x+cos(ang)*r*s;
      float yy = y+sin(ang)*r*s;
      noStroke();
      fill(#DEDFE3);
      //if(random(1) < 0.05) fill(80);
      ellipse(xx, yy, s*0.1, s*0.1);
    }


    noStroke();
    fill(0, 10);
    arc2(x +2, y+2, s*0.8, s*1.2, 0, TAU, color(0), 14, 0);
    fill(#DEDFE3);
    ellipse(x, y, s, s);
    fill(255, 10);
    arc(x, y, s, s, PI*1.25, PI*2.25);
    /*
    arc2(x, y, s*0.55, s*0.66, PI*1.25, PI*2.25, color(0), 255, 255);
     arc2(x, y, s*0.55, s*0.66, PI*1.25, PI*(1.25+random(1)), #9AE32E, 255, 255);
     arc2(x, y, s*0.5, s*0.56, PI*1.25, PI*2.25, color(120), 255, 255);
     */


    fill(200);
    stroke(140);
    strokeWeight(s*0.02);
    ellipse(x, y, s*0.1, s*0.1);
  }
}



void rects(float grid, float ss) {
  for (int i = 0; i < 100; i++) {
    float xx = random(width);
    float yy = random(height);
    xx -= xx%grid;
    yy -= yy%grid;
    rect(xx, yy, ss, ss);
  }
}


ArrayList<PVector> createPoints() {
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 100; i++) {
    float aa = random(TAU);
    float dd = acos(random(random(1), 1))*width*0.25;
    float x = width*0.5+cos(aa)*dd;//random(width);
    float y = height*0.5+sin(aa)*dd;//random(height);
    float s = width*random(0.02, 0.1);
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p2 = points.get(j);
      float dis = dist(x, y, p2.x, p2.y);
      if (dis < (s+p2.z)) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }
  return points;
}



void back() {
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 20000; i++) {
    float x = width*random(-0.1, 1.1);
    float y = height*random(-0.1, 1.1);
    float s = width*0.004;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p2 = points.get(j);
      float dis = dist(x, y, p2.x, p2.y);
      if (dis < (s+p2.z)) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }


  ArrayList triangles = Triangulate.triangulate(points);
  stroke(0, 4);
  strokeWeight(1);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    fill(0, random(8));
    vertex(t.p1.x, t.p1.y);
    //fill(0, random(20));
    vertex(t.p2.x, t.p2.y);
    //fill(0, random(20));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
}

void circle(float x, float y, float r1, float r2, int c, float a) {
  float da = TAU/c;
  for (int i = 0; i < c; i++) {
    float dx = cos(da*i+a); 
    float dy = sin(da*i+a);
    line(x+dx*r1, y+dy*r1, x+dx*r2, y+dy*r2);
  }
}


void grid(float sep, float ss) {
  rectMode(CENTER);
  for (float j = 0; j <= height; j+=sep) {
    for (int i = 0; i <= width; i+=sep) {
      rect(i, j, ss, ss);
    }
  }
}

void back1() {

  float ss = 5;
  int cw = int(width/ss);
  int ch = int(height/ss);

  noStroke();
  fill(255, 100);
  float det = random(0.01);
  float des = random(1000);
  noiseDetail(2);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      float x = i*ss;
      float y = j*ss;
      float n = pow(noise(des+x*det, des+y*det), 2);
      float amp = 1*n;//random(1.41);
      ellipse(i*ss, j*ss, ss*amp, ss*amp);
    }
  }
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

void arc3(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    float aa1 = map(i, 0, cc, alp1, alp2);
    float aa2 = map(i+1, 0, cc, alp1, alp2);
    beginShape();
    fill(col, aa1);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    fill(col, aa2);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
