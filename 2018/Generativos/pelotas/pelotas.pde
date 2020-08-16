int seed = int(random(999999));
float time;

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  noiseDetail(1);

  generate();
}

void draw() {
  //generate();
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
  int grad = rcol();
  background(back);

  ArrayList<PVector> circles = new ArrayList<PVector>();

  for (int i = 0; i < 1000000; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(20, 260);

    boolean add = true;
    for (int j = 0; j < circles.size(); j++) {
      PVector p = circles.get(j);
      if (dist(x, y, p.x, p.y) < (s+p.z)*0.55) {
        add = false; 
        break;
      }
    }
    if (add) {
      circles.add(new PVector(x, y, s));
    }
  }

  noStroke();
  for (int i = 0; i < circles.size(); i++) {
    PVector p = circles.get(i);
    arc2(p.x, p.y, 0, p.z, 0, TAU, grad, 20, 0);
  }

  noFill();
  int sha = lerpColor(back, color(20), 0.1);
  for (int i = 0; i < circles.size(); i++) {
    PVector p = circles.get(i);
    float ss = p.z*0.5;
    int col = rcol();
    while (col == back) col = rcol();
    int cc = int(random(3, 13));
    float da = TWO_PI/cc;
    float a = random(TAU);
    float r1 = ss*0.5;
    float r2 = ss*0.9;
    strokeWeight(ss*0.2);
    stroke(sha);
    ellipse(p.x+2, p.y+2, ss*0.4, ss*0.4);
    for (int j = 0; j < cc; j++) {
      float dx = cos(da*j+a);
      float dy = sin(da*j+a);
      line(p.x+dx*r1+2, p.y+dy*r1+2, p.x+dx*r2, p.y+dy*r2);
    }

    stroke(col);
    ellipse(p.x, p.y, ss*0.4, ss*0.4);
    for (int j = 0; j < cc; j++) {
      float dx = cos(da*j+a);
      float dy = sin(da*j+a);
      line(p.x+dx*r1, p.y+dy*r1, p.x+dx*r2, p.y+dy*r2);
    }

    stroke(back);
    strokeWeight(ss*0.1);
    ellipse(p.x, p.y, ss*0.4, ss*0.4);
    for (int j = 0; j < cc; j++) {
      float dx = cos(da*j+a);
      float dy = sin(da*j+a);
      line(p.x+dx*r1, p.y+dy*r1, p.x+dx*r2, p.y+dy*r2);
    }
  }

  beginShape();
  fill(rcol(), 30);
  vertex(0, 0);
  vertex(width, 0);
  fill(rcol(), 30);
  vertex(width, height);
  vertex(0, height);
  endShape();
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
int colors[] = {#F8C43D, #023390, #6AA6E2, #F35076, #F6F6F6};
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