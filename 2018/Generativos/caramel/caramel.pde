int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
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

  float ang = random(PI*0.2, PI*0.8);

  ArrayList<PVector> points = new ArrayList<PVector>();

  noStroke();
  int cc = int(random(random(200000)));
  for (int i = 0; i < cc; i++) {
    float xx = random(width);
    float yy = random(height);
    float ss = width*random(0.3);

    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector p = points.get(j);
      if (dist(xx, yy, p.x, p.y) < (ss+p.z)*0.6) {
        add = false;
      }
    }

    if (!add) continue;
    else points.add(new PVector(xx, yy, ss));

    float dx = cos(ang+HALF_PI)*ss*0.5;
    float dy = sin(ang+HALF_PI)*ss*0.5;
    float sx = cos(ang)*ss*3;
    float sy = sin(ang)*ss*3;

    arc2(xx, yy, ss, ss*1.06, 0, TAU, color(0), 10, 0);
    arc2(xx, yy, ss, ss*1.4, 0, TAU, color(0), 20, 0);

    beginShape();
    fill(0, 20);
    vertex(xx-dx, yy-dy);
    vertex(xx+dx, yy+dy);
    fill(0, 0);
    vertex(xx+dx+sx*0.3, yy+dy+sy*0.3);
    vertex(xx-dx+sx*0.3, yy-dy+sy*0.3);
    endShape(CLOSE);


    beginShape();
    fill(0, 10);
    vertex(xx-dx, yy-dy);
    vertex(xx+dx, yy+dy);
    fill(0, 0);
    vertex(xx+dx+sx, yy+dy+sy);
    vertex(xx-dx+sx, yy-dy+sy);
    endShape(CLOSE);
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(rcol());
    ellipse(p.x, p.y, p.z, p.z);
    arc2(p.x, p.y, p.z, p.z*0.7, 0, TAU, rcol(), 6, 0);
    arc2(p.x, p.y, p.z, p.z*3, 0, TAU, rcol(), 5, 0);
    arc2(p.x, p.y, p.z, p.z*1.4, 0, TAU, rcol(), 5, 0);
  }
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#01903B, #FEE643, #F3500A, #0066B8, #583106, #F4EEE0};
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