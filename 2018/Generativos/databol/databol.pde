int seed = int(random(999999));
PFont font;
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  font = createFont("Chivo", 40, true);
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
  background(rcol());

  int cd = int(random(60, 110));
  float dd = width*1./cd;
  noStroke();
  int dcol = rcol();
  float det = 0.01;//random(0.1);
  float des = random(10000);
  noiseDetail(1);
  for (int j = 0; j <= cd; j++) {
    for (int i = 0; i <= cd; i++) {
      float x = i*dd;
      float y = j*dd;
      float amp = noise(des+x*det, des+y*det);
      if (amp > 0.1) {
        float ss = map(amp, 0.1, 1, 0, 1)*dd*0.6;
        int col = rcol();
        fill(col, 8);
        ellipse(x+0.5, y+0.5, dd, dd);
        fill(col, 250);
        ellipse(x+0.5, y+0.5, ss, ss);
      }
      fill(dcol, 80);
      rect(x, y, 1, 1);
      fill(rcol(), 80);
      rect(x+dd*0.5, y+dd*0.5, 1, 1);
    }
  }

  int cdc = int(random(1, 40));
  for (int i = 0; i < cdc; i++) {
    float x = random(width); 
    float y = random(height);
    x -= x%dd;
    y -= y%dd;
    float s = dd*int(random(1, 8));
    int col = rcol();
    stroke(col, 30);
    fill(col, 10);
    ellipse(x+0.5, y+0.5, s, s);
    fill(col);
    ellipse(x+0.5, y+0.5, s*0.1, s*0.1);
  }

  int c = int(random(1, 40));
  //c = 1;
  for (int k = 0; k < c; k++) {
    float cx = width/2;//random(width);
    float cy = height/2;//random(height);
    ArrayList<PVector> points = new ArrayList<PVector>();
    float ss = width*random(0.4, 0.6)*random(0.4, 1)*random(0.2, 1);
    ss = width*random(0.1, 0.3);
    int cc = int(random(3, 60));
    cc = int(random(3, 20));
    float a = random(TWO_PI);
    float da = TWO_PI/cc;
    for (int i = 0; i < cc; i++) {
      float ang = a+da*i+random(da);
      float dis = atan(random(PI))*ss;
      points.add(new PVector(cx+cos(ang)*dis, cy+sin(ang)*dis, 0));
    }
    Spline spline = new Spline(points);

    stroke(0, 20);
    noFill();
    beginShape();
    for (int i = 0; i < spline.length; i++) {
      float v = map(i, 0, spline.length, 0, 1);
      PVector p = spline.getPoint(v);
      vertex(p.x+0.5, p.y+0.5);
    }
    endShape(CLOSE);
    stroke(rcol());
    noFill();
    beginShape();
    for (int i = 0; i < spline.length; i++) {
      float v = map(i, 0, spline.length, 0, 1);
      PVector p = spline.getPoint(v);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);

    float len = 0;
    stroke(rcol(), 50);
    float maxs = ss*random(0.1, random(0.5+random(0.5)));
    while (len < spline.length) {
      float s = maxs*random(0.1, 1);
      float vv = map(len+s*0.5, 0, spline.length, 0, 1);
      PVector p = spline.getPoint(vv);
      float ang = spline.getDir(vv).heading();
      float bor = s*random(0.5);
      len += s;
      noStroke();
      rectMode(CENTER);
      pushMatrix();
      translate(p.x, p.y);
      rotate(ang);
      fill(0, 4);
      rect(0, 0, s*1.05, s*1.05, bor*1.05);
      fill(rcol());
      rect(0, 0, s, s, bor);
      fill(rcol());
      float sca = random(0.4);
      rect(0, 0, s*sca, s*sca, bor*sca);
      fill(rcol());
      ellipse(0, 0, s*sca*0.1, s*sca*0.1);
      /*
      int col = rcol();
       stroke(col);
       fill(col);
       float x = width*random(0.2, 0.3);
       float y = height*random(0.2, 0.3);
       line(0, 0, x, y);
       ellipse(x, y, 50, 50);
       
       char data = "+-".charAt(int(random(4)));
       textAlign(CENTER, CENTER);
       textFont(font);
       fill(rcol());
       text(data, x, y);
       */
      popMatrix();
    }

    for (int i = 0; i < 2; i++) {
      float x = random(width);
      float y = random(height);
      float s = random(3, 12);
      float d = s*random(1.1, 1.5);
      int ccc = int(random(1, 10));
      for (int j = 0; j < ccc; j++) {
        fill(rcol());
        rect(x+d*j, y, s, s, s*0.1);
      }
    }
  }

  for (int j = 0; j < 100; j++) {
    pushMatrix();
    //translate(width/2, height/2);
    rotate(HALF_PI*0.5);
    float x = width*random(-0.5, 0.5);
    float y = height*random(-0.5, 0.5);
    float w = random(20);
    float h = random(500);
    beginShape();
    fill(rcol());
    vertex(-w*0.5, -h*0.5);
    vertex(+w*0.5, -h*0.5);
    fill(rcol());
    vertex(+w*0.5, +h*0.5);
    vertex(-w*0.5, +h*0.5);
    popMatrix();
  }
} 

class Spline {
  ArrayList<PVector> points;
  float dists[];
  float length;
  Spline(ArrayList<PVector> points) {
    this.points = points;
    calculate();
  }
  void calculate() {
    dists = new float[points.size()+1];
    length = 0; 

    int res = 10;
    for (int i = 0; i <= points.size(); i++) {
      float ndis = 0;
      PVector ant = getPointLin(i);
      for (int j = 1; j <= res; j++) {
        PVector act = getPointLin(i+j*1./res);
        ndis += ant.dist(act);
        ant = act;
      }
      dists[i] = length;
      if (points.size() != i) length += ndis;
    }
  }
  PVector getPointLin(float v) {
    v = v%points.size();
    int ind = int(v);
    float m = v%1.;
    return calculatePoint(ind, m);
  }
  PVector getPoint(float v) {
    v = (v%1)*length;
    int ind = 0;
    float antLen = dists[ind];
    float actLen = dists[ind+1];
    while (actLen < v && ind <= points.size()) { 
      ind++;
      antLen = actLen;
      actLen = dists[(ind+1)];
    }
    float m = map(v, antLen, actLen, 0, 1);
    return calculatePoint(ind, m);
  }
  PVector calculatePoint(int ind, float m) {
    int ps = points.size();
    PVector p1 = points.get((ind-1+ps)%ps);
    PVector p2 = points.get((ind+0+ps)%ps);
    PVector p3 = points.get((ind+1+ps)%ps);
    PVector p4 = points.get((ind+2+ps)%ps);
    float xx = curvePoint(p1.x, p2.x, p3.x, p4.x, m);
    float yy = curvePoint(p1.y, p2.y, p3.y, p4.y, m);
    float zz = curvePoint(p1.z, p2.z, p3.z, p4.z, m);
    return new PVector(xx, yy, zz);
  }
  PVector getDir(float v) {
    PVector act = getPoint(v);
    PVector p1 = act.copy().sub(getPoint(v-0.01));
    PVector p2 = getPoint(v+0.01).sub(act);
    PVector aux = p1.add(p2).mult(0.5);
    return aux.normalize();
  }
  PVector getCenter() {
    PVector center = new PVector();
    for (int i = 0; i < points.size(); i++) {
      center.add(points.get(i));
    }
    center.div(points.size());
    return center;
  }
}  

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#011731, #A12677, #EE3C7A, #EE2D30, #EC4532, #FFCA2A, #3DB98A, #16A5DF};
//int colors[] = {#FE4D9F, #EE1C25, #2F3293, #3CB74C, #0272BE, #BDCBD5, #FEFEFE};
//int colors[] = {#FFFFFF, #02F602, #0056E9};
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