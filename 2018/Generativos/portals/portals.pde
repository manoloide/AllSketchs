int seed = int(random(999999));
PFont chivo;
void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  chivo = createFont("Chivo", 10, true);

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

class Line {
  color col;
  float x1, y1, x2, y2, s;
  float dis, ang;
  Line(float x1, float y1, float x2, float y2, float s) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.s = s;
  }

  void draw() {
    float a1 = random(TWO_PI);
    float a2 = random(TWO_PI);
    float ic = random(colors.length);
    float dc = random(0.01, 0.1)*random(3);

    float ach = random(0.01, 0.02);
    float vel = random(0.01)*2;
    dis = dist(x1, y1, x2, y2);
    while (dis > 1) {
      ang = atan2(y2-y1, x2-x1);
      ic += dc;
      col = getColor(ic);

      a1 += random(-0.1, 0.1);
      a2 += random(-0.1, 0.1);

      x1 += cos(a1)*vel*dis;
      y1 += sin(a1)*vel*dis;
      x2 += cos(a2)*vel*dis;
      y2 += sin(a2)*vel*dis;

      x1 += cos(ang)*dis*ach;
      y1 += sin(ang)*dis*ach;
      x2 -= cos(ang)*dis*ach;
      y2 -= sin(ang)*dis*ach;

      show();
      dis = dist(x1, y1, x2, y2);
    }
  }

  void show() {
    noStroke();
    float r = dis*s;
    float dx1 = cos(ang-HALF_PI*0.5)*r;
    float dy1 = sin(ang-HALF_PI*0.5)*r;
    float dx2 = cos(ang+HALF_PI*0.5)*r;
    float dy2 = sin(ang+HALF_PI*0.5)*r;
    fill(col);
    beginShape();
    vertex(x1-dx1, y1-dy1);
    vertex(x1-dx2, y1-dy2);
    vertex(x2+dx1, y2+dy1);
    vertex(x2+dx2, y2+dy2);
    endShape(CLOSE);
  }
}

void generate() {
  background(25);

  ArrayList<Line> lines = new ArrayList<Line>(); 
  for (int i = 0; i < 1; i++) {
    float xx = random(width);
    float yy = random(height);
    float ang = random(TWO_PI);
    float dis = width*random(0.1, 0.8)*random(0.8);
    float dx = cos(ang)*dis;
    float dy = sin(ang)*dis;

    lines.add(new Line(xx+dx, yy+dy, xx-dx, yy-dy, random(0.05, 0.4)));
  }

  float des = random(100000);
  float det = random(0.01);
  for (int i = 0; i < lines.size(); i++) {
    lines.get(i).draw();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#24A4D2, #FBFBFB, #E2E72C, #92C871, #171D31};
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