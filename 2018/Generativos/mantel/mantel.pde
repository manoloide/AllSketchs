int seed = int(random(999999));

void setup() {
  size(3250, 3250, P2D);
  smooth(2);
  pixelDensity(2);
  strokeWeight(3);

  generate();
  saveImage();
  exit();
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
  color back = rcol();
  background(back);

  ArrayList<PVector> points = new ArrayList<PVector>();

  float des = random(1000000);
  float det = random(0.004, 0.03)/(width*1./960);

  for (int i = 0; i < 3000; i++) {
    stroke(rcol(), 80);
    fill(rcol(), 240);
    float x = random(width);
    float y = random(width);
    beginShape();
    float dis = width/9.6;
    for (int j = 0; j < dis; j++) {
      float ang = noise(des+x*det, des+y*det)*TWO_PI;
      x += cos(ang);
      y += sin(ang);
      vertex(x, y);
    }
    endShape(CLOSE);
  }


  noiseDetail(1);
  for (int i = 0; i < 80000; i++) {
    float x = random(width);
    float y = random(height);
    float dis = dist(x, y, width/2, height/2);
    dis = dis/(width*1.41);
    dis = map(dis, 0, 1, 2, 1);
    float s = width*random(0.1)*random(0.5, 1)*dis;
    s = width*noise(des+x*det, des+y*det)*dis*random(0.05, 0.2);


    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < (s+o.z)*0.6) {
        add = false;
        break;
      }
    }

    if (add) points.add(new PVector(x, y, s));
  }

  noStroke();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(lerpColor(back, color(0), random(0.05, 0.15)), 80);
    float r = p.z*0.5;
    int res = max(8, int(PI*r));
    float da = TWO_PI/res;
    beginShape();
    for (int j = 0; j < res; j++) {
      float ang = da*j;
      float sa = (ang+PI*1.75)%TWO_PI;
      sa = abs(sa-PI);
      if (sa < HALF_PI) sa = HALF_PI;
      float rr = r*(1.2-pow(abs(sin(sa)), 1.5)*0.2);
      float x = p.x+cos(ang)*rr;
      float y = p.y+sin(ang)*rr;
      vertex(x, y);
    }
    endShape(CLOSE);
    arc2(p.x, p.y, p.z, p.z*1.5, 0, TAU, 0, 20, 0);

    //ellipse(p.x+p.z*0.3, p.y+p.z*0.4, p.z, p.z);
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    color col = rcol();
    fill(col);
    ellipse(p.x, p.y, p.z, p.z);
    arc2(p.x, p.y, p.z, p.z*0.0, 0, TAU, 0, 5, 0);
    arc2(p.x, p.y, p.z, p.z*0.5, 0, TAU, 0, 20, 0);
    arc2(p.x+p.z*0.125, p.y-p.z*0.125, p.z*0.0, p.z*0.5, 0, TAU, 255, 20, 0);

    //noiseCircle(p.x, p.y, p.z, p.z*1.2, 255, 70, 0);
    //noiseCircle(p.x, p.y, p.z, p.z*1.2, 255, 70, 0);

    float r = p.z*0.5;
    ArrayList<PVector> pp = new ArrayList<PVector>();
    for (int j = 0; j < 800; j++) {
      float ang = random(TWO_PI);
      float dis = acos(random(PI));
      float x =  cos(ang)*dis*(r*0.6);
      float y =  sin(ang)*dis*(r*0.6);
      float ss = r*random(0.04, 0.1);

      boolean add = true;
      for (int k = 0; k < pp.size(); k++) {
        PVector o = pp.get(k);
        if (dist(x, y, o.x, o.y) < (ss+o.z)*0.5) {
          add = false;
          break;
        }
      }

      if (add) {
        pp.add(new PVector(x, y, ss));

        fill(0, 120);
        arc(p.x+x, p.y+y, ss, ss*1.6, 0, PI);

        fill(rcol());
        ellipse(p.x+x, p.y+y, ss, ss);
      }
    }
  }
}

void noiseCircle(float x, float y, float s1, float s2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  int res = max(8, int(PI*min(r1, r2))); 
  float da = TWO_PI/res;

  float des = random(1000);
  float det = random(1, 3);
  noiseDetail(1);
  for (int i = 0; i < res; i++) {
    beginShape();
    float a1 = da*i;
    float a2 = da*i+da;
    float n1 = noise(des+cos(a1)*det, des+sin(a1)*det);
    float n2 = noise(des+cos(a2)*det, des+sin(a2)*det);
    float rr1 = map(n1, 0, 1, r1, r2);
    float rr2 = map(n2, 0, 1, r1, r2);
    fill(col, shd1);
    vertex(x+cos(a2)*rr2, y+sin(a2)*rr2);
    vertex(x+cos(a1)*rr1, y+sin(a1)*rr1);
    fill(col, shd2);
    vertex(x+cos(a1)*r1, y+sin(a1)*r1);
    vertex(x+cos(a2)*r1, y+sin(a2)*r1);
    endShape(CLOSE);
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#D81D03, #101A9D, #1C7E4E, #F6A402, #EFD4BF, #E2E0EF, #050400};
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