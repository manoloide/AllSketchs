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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

float detSize;
float desSize;
float detColor = random(0.004, 0.006)*0.1;
float desColor = random(1000); 

void generate() { 

  randomSeed(seed);
  noiseSeed(seed);

  background(252);

  noiseDetail(2, 0.45);

  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> ptrian = new ArrayList<PVector>();
  ArrayList<PVector> select = new ArrayList<PVector>();

  int maxSelect = 40;

  detSize = random(0.004, 0.006)*0.8;
  desSize = random(1000);
  detColor = random(0.004, 0.006)*0.4;
  desColor = random(1000);  

  float maxSize = 360;
  float pwrNoise = 2;

  for (int i = 0; i < 200000; i++) { //1000000
    float x = random(-maxSize, width+maxSize);
    float y = random(-maxSize, height+maxSize);
    float s = pow(noise(desSize+x*detSize, desSize+y*detSize)*random(0.6, 1), pwrNoise)*maxSize;
    PVector p = new PVector(x, y, s);

    boolean add = true;

    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      float dist = dist(p.x, p.y, o.x, o.y);
      if (dist < (p.z+o.z)*0.5) {
        add = false;
        break;
      }
    }

    if (add && select.size() < maxSelect && s > 30) {
      boolean addSelect = true;
      for (int j = 0; j < select.size(); j++) {
        PVector o = select.get(j);
        float dist = dist(p.x, p.y, o.x, o.y);
        if (dist < (p.z+o.z)) {
          addSelect = false;
          break;
        }
      }
      if (addSelect) select.add(p.copy());
    }

    if (add) {
      points.add(p);
      if (s > 10) ptrian.add(new PVector(x, y));
    }
  }


  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    if (p.z < 10) {
      float val = map(p.z, 0, 10, 0, 1);
      fill(getColor(val*colors.length*10+colors.length-1), val*256);
    } else {
      fill(getColor(map(p.z, 0, maxSize, 0, colors.length*3)));
    }
    ellipse(p.x, p.y, p.z*0.98, p.z*0.98);
  }

  tris(ptrian);


  ArrayList triangles = Triangulate.triangulate(select);
  stroke(0, 40);
  noFill();
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);

    stroke(0, 50);
    strokeWeight(1);
    int col = rcol();
    int sel = int(random(3));
    beginShape();
    if (sel == 0) fill(col, 20);
    else fill(col, 0);
    vertex(t.p1.x, t.p1.y);
    if (sel == 1) fill(col, 20);
    else fill(col, 0);
    vertex(t.p2.x, t.p2.y);
    if (sel == 2) fill(col, 20);
    else fill(col, 0);
    vertex(t.p3.x, t.p3.y);
    endShape();

    PVector cen = t.p1.copy().add(t.p2).add(t.p3).div(3);

    noStroke();
    fill(255, 40);
    ellipse(cen.x, cen.y, 5, 5);
    ellipse(cen.x, cen.y, 8, 8);


    strokeWeight(1);
    connection(t.p1, t.p2);
    connection(t.p2, t.p3);
    connection(t.p3, t.p1);
    strokeWeight(1);
  }



  noStroke();
  for (int i = 0; i < select.size(); i++) {
    PVector p = select.get(i);
    int col = getColor(map(p.z, 0, maxSize, 0, colors.length*3));
    noStroke();
    fill(250);
    int cc = noiseColor(p.x, p.y);
    arc2(p.x, p.y, p.z*1, p.z*2.2, 0, TAU, cc, 120, 0);
    fill(255, 40);
    noStroke();
    ellipse(p.x, p.y, p.z*1.06, p.z*1.06);
    fill(255);
    ellipse(p.x, p.y, p.z*1, p.z*1);
  }

  stroke(0, 40);
  for (int i = 0; i < ptrian.size(); i++) {
    PVector p = ptrian.get(i);
    fill(noiseColor(p.x, p.y));
    ellipse(p.x, p.y, 3, 3);
  }
}

int noiseColor(float x, float y) {
  return getColor(noise(desColor+x*detColor, desColor+y*detColor)*colors.length);
}

void connection(PVector p1, PVector p2) {
  float dis = p1.dist(p2);
  float ang = atan2(p2.y-p1.y, p2.x-p1.x);

  float sep = 4;
  float ini = (dis%sep)*0.5;

  float a1 = ang+HALF_PI;
  float a2 = ang-HALF_PI;

  for (float i = ini; i < dis; i+=sep) {
    float v = map(i, 0, dis, 0, 1);
    float x = lerp(p1.x, p2.x, v); 
    float y = lerp(p1.y, p2.y, v);
    float noi = pow(noise(desSize+x*detSize, desSize+y*detSize), 1.3);
    float amp = sin(v*PI)*dis*0.04*noi;
    stroke(noiseColor(x, y), 120);
    line(x+cos(a1)*amp, y+sin(a1)*amp, x+cos(a2)*amp, y+sin(a2)*amp);
  }
}

void tris(ArrayList<PVector> points) {
  ArrayList triangles = Triangulate.triangulate(points);

  float detColor = random(0.004, 0.006)*2;
  float desColor = random(1000);

  stroke(0, 40);
  fill(255, 40);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);

    boolean col = (random(1) < 0.1);

    beginShape();
    fill(255, 40);
    if (col) fill(getColor(noise(detColor+t.p1.x*desColor, detColor+t.p1.y*desColor)*colors.length), 70);
    vertex(t.p1.x, t.p1.y);
    if (col) fill(getColor(noise(detColor+t.p2.x*desColor, detColor+t.p2.y*desColor)*colors.length), 70);
    vertex(t.p2.x, t.p2.y);
    if (col) fill(getColor(noise(detColor+t.p3.x*desColor, detColor+t.p3.y*desColor)*colors.length), 70);
    vertex(t.p3.x, t.p3.y);
    endShape();
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma*0.5));
  float da = amp/cc;
  beginShape(QUADS);
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
  }
  endShape(CLOSE);
}

int colors[] = {#DAAC80, #FCC9D2, #FC2E1D, #235F3F, #02272D};
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
