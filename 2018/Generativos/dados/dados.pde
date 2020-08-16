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

  int back = rcol();
  //back = colors[1];

  randomSeed(seed);
  noiseSeed(seed);
  background(back);

  strokeWeight(0.5);
  stroke(255, 4);
  for (int i = 0; i < 5; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(width);
    arc2(x, y, s*0.1, s, 0, TAU, rcol(), 0, random(100, 200));
  }


  noStroke();
  for (int i = 0; i < 2000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(3);
    fill(rcol());
    ellipse(x, y, s, s);
  }

  for (int i = 0; i < 26; i++) {
    int sub = int(pow(2, (1+int(random(6)))));
    float ss = width*1./sub;
    stroke(rcol(), random(200, 255));
    strokeWeight(ss*random(0.05));
    for (int j = 0; j <= sub; j++) {
      line(j*ss, 0, j*ss, height);
      line(0, j*ss, width, j*ss);
    }
    for (int j = 0; j < sub*0.04; j++) {
      float x = ss*int(random(sub));
      float y = ss*int(random(sub));
      noStroke();
      fill(rcol(), random(200));
      rect(x, y, ss, ss);
    }
  }

  int sub = 16;
  float ss = width*1./sub;
  float ax = 0;
  float ay = 0;
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 30; i++) {
    float x = int(random(-4, sub+4))*ss;
    float y = int(random(-4, sub+4))*ss;
    float s = ss*random(0.2, 1)*random(1);

    points.add(new PVector(x, y, s));
  }


  ArrayList triangles = Triangulate.triangulate(points);
  // draw the mesh of triangles
  stroke(0, 40);
  fill(255, 40);
  beginShape(TRIANGLES);

  strokeWeight(2);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    stroke(rcol());
    fill(rcol(), random(200)*random(1));
    vertex(t.p1.x, t.p1.y);
    fill(rcol(), random(200)*random(1));
    stroke(rcol());
    vertex(t.p2.x, t.p2.y);
    stroke(rcol());
    fill(rcol(), random(200)*random(1));
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    float s = p.z;
    if (i > 0) wire(ax, ay, p.x, p.y);
    ax = p.x;
    ay = p.y;

    fill(rcol());
    ellipse(p.x, p.y, s, s);
    s *= random(0.2, 0.6);
    fill(rcol());
    ellipse(p.x, p.y, s, s);
  }


  for (int k = 0; k < 2; k++) {
    int cc = int(random(200));
    ss = width*1./cc;
    fill(rcol(), random(200));
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        rect((i-0.05)*ss, (j-0.05)*ss, ss*0.1, ss*0.1);
      }
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}


void wire(float x1, float y1, float x2, float y2) {
  float dy = abs(y1-y2)+abs(x1-x2);
  float cx = (x1+x2)*0.5;
  float cy = (y1+y2)*0.5+dy*random(0.4, 1.2);
  /*
  noFill();
   stroke(rcol());
   strokeWeight(0.5);
   beginShape();
   curveVertex(x1, y1);
   curveVertex(x1, y1);
   curveVertex(cx, cy);
   curveVertex(x2, y2);
   curveVertex(x2, y2);
   endShape();
   */


  strokeWeight(1);
  noStroke();
  int steps = int(dist(x1, y1, cx, cy)*6);
  float pwr = 1;//random(0.1, 2);

  float maxSize = random(10, 30)*0.15;
  float minSize = maxSize*random(0.6, 1);

  float os = random(0.012);
  float ic = random(colors.length);
  for (int i = 0; i <= steps; i++) {
    float t = i / float(steps);
    float x = curvePoint(x1, x1, cx, x2, t);
    float y = curvePoint(y1, y1, cy, y2, t);
    float s = map(t, 0, 1, 0.2, 0.5);
    s = map(pow(cos(i*os), pwr), 0, 1, minSize*s, maxSize*s);
    noStroke();
    fill(getColor(ic+t*colors.length));
    ellipse(x, y, s, s);
  }
  ic += steps*colors.length;
  for (int i = 0; i <= steps; i++) {
    float t = i / float(steps);
    float x = curvePoint(x1, cx, x2, x2, t);
    float y = curvePoint(y1, cy, y2, y2, t);
    float s = map(t, 0, 1, 0.5, 1);
    s = map(pow(cos(i*os), pwr), 0, 1, minSize*s, maxSize*s);
    noStroke();
    fill(getColor(ic+t*colors.length));
    ellipse(x, y, s, s);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FFFFFF, #FFFFFF, #FFCB43, #FFB9D5, #1DB5E3, #006591, #142B4B};
//int colors[] = {#FFFFFF, #FFC930, #F58B3F, #395942, #212129};
//int colors[] = {#F8F8F9, #FE3B00, #7233A6, #0601FE, #000000};
//int colors[] = {#FFFFFF, #F7C6D9, #F4CA75, #4D67FF, #657F66};
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
