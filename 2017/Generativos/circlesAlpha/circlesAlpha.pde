void setup() {
  size(960, 960);
  rectMode(CENTER);
  generate();
}


void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  background(0);

  ArrayList<PVector> points = new ArrayList<PVector>();

  int dw = int(random(2, random(20)));
  int dh = int(random(2, random(20)));


  for (int j = 0; j <= dh; j++) {
    float yy = map(j, 0, dh, 0, height);
    for (int i = 0; i <= dw; i++) {
      float xx = map(i, 0, dw, 0, width);
      points.add(new PVector(xx, yy));
    }
  }

  stroke(255, 40);
  for (int i = 0; i <= dw; i++) {
    float xx = map(i, 0, dw, 0, width);
    line(xx, 0, xx, height);
  }
  for (int i = 0; i <= dh; i++) {
    float yy = map(i, 0, dh, 0, height);
    line(0, yy, width, yy);
  }

  float sw = width*1./dw;
  float sh = height*1./dh;

  noFill();
  float maxStroke = random(random(256));
  int c = int(random(80)*random(0.1, 1));
  for (int i = 0; i < c; i++) {
    PVector p = points.get(int(random(points.size())));
    float x = p.x;
    float y = p.y;
    float s = (random(1) < 0.5)? sw*int(random(1, dw)) : sh*int(random(1, dh));
    int cc = int(random(5, 10));
    stroke(255, random(maxStroke)*random(1));
    fill(rcol(), 20);
    for (int j = 0; j < cc; j++) {
      float ss = s*map(j, 0, cc, 1, 0);
      ellipse(x, y, ss, ss);
      ellipse(width-x, y, ss, ss);
      ellipse(width-x, height-y, ss, ss);
      ellipse(x, height-y, ss, ss);
    }
  }
}

int colors[] = {#e25300, #f5d600, #d5456c, #7ac0df};
int rcol() {
  return colors[int(random(colors.length))];
};