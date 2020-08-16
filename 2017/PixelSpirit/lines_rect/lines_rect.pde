void setup() {

  size(960, 960);
  generate();
}

void draw() {
  /*
  background(255);
   float x1 = mouseX;
   float y1 = mouseY;
   float x2 = width/2;
   float y2 = height/2;
   float s = 20;
   line(x1, y1, x2, y2);
   
   float ang = atan2(y1-y2, x1-x2)-PI/4;
   line(x1+cos(ang)*s, y1+sin(ang)*s, x2+cos(ang)*s, y2+sin(ang)*s);
   line(x1-cos(ang)*s, y1-sin(ang)*s, x2-cos(ang)*s, y2-sin(ang)*s);
   */
}

void keyPressed() {
  if (key == 's') saveImage();
  if (key == 'g') generate();
}

void generate() {
  background(180);


  for (int i = 0; i < 10; i++) {

    ArrayList<PVector> points = new ArrayList<PVector>();

    float x = random(width);
    float y = random(height);
    int dir = int(random(4));
    float dd = random(80, 600);
    points.add(new PVector(x, y));
    float d2 = dd*random(0.12, 0.3);
    int cd = (random(1) < 0.5)? 1 : -1;
    for (int j = 0; j < 200; j++) {
      float d = dd;//*random(0.8, 1.2);
      x += cos(HALF_PI*dir)*d;
      y += sin(HALF_PI*dir)*d;
      points.add(new PVector(x, y));
      dir+=cd;
      for (int k = 0; k < 2; k++) {
        x += cos(HALF_PI*dir)*d2;
        y += sin(HALF_PI*dir)*d2;
        points.add(new PVector(x, y));
        dir+=cd;
      }
    }

    /*
    for (int j = 0; j < 10; j++) {
     points.add(new PVector(random(width), random(height)));
     }
     */

    fill(255);
    drawLine(points, random(10, 70), int(random(1, random(8))));
  }
}

void drawLine(ArrayList<PVector> points, float str, int sub) {
  float r = str*0.5;

  int colFill = g.fillColor;
  int colStro = g.strokeColor;

  fill(colFill);
  int adir = 1;
  int dir = 1;

  for (int i = 1; i < points.size()-1; i++) {
    PVector a = points.get(i-1);
    PVector p = points.get(i);
    PVector n = points.get(i+1);

    float a1 = (TWO_PI+atan2(a.y-p.y, a.x-p.x))%TWO_PI;
    float a2 = (TWO_PI+atan2(n.y-p.y, n.x-p.x))%TWO_PI;
    float ma = (a1+a2)*0.5;


    dir = (difAngle(a1, a2) >= 0)? -1 : 1;
    int change = (dir != adir)? 1 : 0;
    //stroke(colFill);
    noStroke();

    float ad = HALF_PI*dir;
    if (change == 1) ad = PI;

    float x1 = a.x+cos(ma-ad+PI*change)*r;
    float y1 = a.y+sin(ma-ad+PI*change)*r;
    float x2 = a.x+cos(ma+ad)*r;
    float y2 = a.y+sin(ma+ad)*r;
    float x3 = p.x-cos(ma)*r;
    float y3 = p.y-sin(ma)*r;
    float x4 = p.x+cos(ma)*r;
    float y4 = p.y+sin(ma)*r;

    beginShape();
    vertex(x1, y1);
    vertex(x2, y2);
    vertex(x3, y3);
    vertex(x4, y4);
    endShape();

    stroke(colStro);
    strokeWeight(r*0.2);
    line(x4, y4, x1, y1);
    line(x2, y2, x3, y3);
    strokeWeight(r*0.05);
    for (int j = 1; j <= sub; j++) {
      float ax1 = lerp(x1, x2, map(j, 0, sub+1, 0, 1));
      float ay1 = lerp(y1, y2, map(j, 0, sub+1, 0, 1));
      float ax2 = lerp(x4, x3, map(j, 0, sub+1, 0, 1));
      float ay2 = lerp(y4, y3, map(j, 0, sub+1, 0, 1));
      line(ax1, ay1, ax2, ay2);
    }
    /*
    fill(255);
     if (change == 1) fill(255, 0, 0);
     ellipse(a.x, a.y, 5, 5);
     ellipse(a.x+cos(ma-ad)*r, a.y+sin(ma-ad)*r, 5, 5);
     ellipse(a.x+cos(ma+ad+PI*change)*r, a.y+sin(ma+ad+PI*change)*r, 5, 5);
     fill(colFill);
     */

    adir = dir;
  }
}

float difAngle(float a1, float a2) {
  a1 = ((a1%TWO_PI)+TWO_PI)%TWO_PI;
  a2 = ((a2%TWO_PI)+TWO_PI)%TWO_PI;
  float diff = max(a1, a2)-min(a1, a2);
  if (diff > PI) diff = TWO_PI - diff;
  int sign = (a1-a2 >= 0 && a1-a2 <= PI) || (a1-a2<=-PI && a1-a2>= -TWO_PI) ? -1 : 1; 
  diff *= sign;
  return diff;
}

class Line {
  ArrayList<PVector> points;
  Line() {
    points = new ArrayList<PVector>();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}