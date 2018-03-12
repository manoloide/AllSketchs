void setup() {
  size(960, 960);
  rectMode(CENTER);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
  /*
  background(240);
   
   drawArc(width/2, height/2, 400, frameCount*0.001%TWO_PI, cos(frameCount*0.007)*TWO_PI);
   */
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
  background(200);
  /*
  float x1 = random(0.2, 0.8)*width;
   float y1 = random(0.2, 0.8)*width;
   float s1 = random(0.4, 0.6)*width;
   
   float x2 = random(0.2, 0.8)*width;
   float y2 = random(0.2, 0.8)*width;
   float s2 = random(0.4, 0.6)*width;
   
   drawCircles(x1, y1, s1, x2, y2, s2);
   */
  lunas();
}

void lunas() {
  int cc = int(random(2, 20));
  float ss = width/(cc+1.);
  float dd = ss;
  noStroke();
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float x1 = dd+i*ss;
      float y1 = dd+j*ss;
      float s1 = ss*0.8;
      float x2 = dd+(i+random(-0.5, 0.5))*ss;
      float y2 = dd+(j+random(-0.5, 0.5))*ss;
      float s2 = ss*0.8;
      /*stroke(0, 20);
       fill(255, 20);
       ellipse(x1, y1, s1, s1);
       */
      //ellipse(x2, y2, s2, s2);
      //stroke(0, 120);
      fill(255, 120);

      moon(x1, y1, s1, random(-1, 1));
    }
  }
}

void moon(float x1, float y1, float s1, float amp) {
  float x2 = x1+map(amp, -1, 1, -s1*0.5, s1*0.5);
  float y2 = y1;//+map(abs(amp), 0, 1, 0, s1*0.3);
  float s2 = map(abs(amp), 0, 1, 1.2, 1)*s1;
  drawCircles(x1, y1, s1, x2, y2, s2);
}

ArrayList<PVector> intersectionsCircles(float x1, float y1, float s1, float x2, float y2, float s2) {
  ArrayList<PVector> aux = new ArrayList<PVector>();
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float a = x2 - x1;
  float b = y2 - y1;
  float ds = a*a + b*b;
  float d = sqrt(ds);
  if (r1 + r2 <= d)
    return aux;

  if (d <= abs( r1 - r2 ))
    return aux;

  float t = sqrt( (d + r1 + r2) * (d + r1 - r2) * (d - r1 + r2) * (-d + r1 + r2) );
  float sx1 = 0.5 * (a + (a*(r1*r1 - r2*r2) + b*t)/ds);
  float sy1 = 0.5 * (b + (b*(r1*r1 - r2*r2) - a*t)/ds);
  float sx2 = 0.5 * (a + (a*(r1*r1 - r2*r2) - b*t)/ds);
  float sy2 = 0.5 * (b + (b*(r1*r1 - r2*r2) + a*t)/ds);

  sx1 += x1;
  sy1 += y1;
  sx2 += x1;
  sy2 += y1;

  aux.add(new PVector(sx1, sy1));
  aux.add(new PVector(sx2, sy2));
  return aux;
}

void drawCircles(float x1, float y1, float s1, float x2, float y2, float s2) {

  ArrayList<PVector> points = intersectionsCircles(x1, y1, s1, x2, y2, s2);
  if (points.size() > 1) {
    PVector p1 = points.get(0);
    PVector p2 = points.get(1);
    float ia1 = atan2(p1.y-y1, p1.x-x1);
    float fa1 = atan2(p2.y-y1, p2.x-x1);
    float ia2 = atan2(p1.y-y2, p1.x-x2);
    float fa2 = atan2(p2.y-y2, p2.x-x2);

    if (ia1+abs(difAngle(ia1, fa1)) < fa1+abs(difAngle(fa1, ia1))) {
      fa1 = ia1-TWO_PI+difAngle(ia1, fa1);
    }

    float ma = (ia2+fa2)*0.5;
    if (dist(x1, y1, x2+cos(ma)*s2*0.5, y1+sin(ma)*s2*0.5) > s1*0.5) {
      ia2 = fa2+difAngle(fa2, ia2);
    }
    beginShape();
    drawArc(x1, y1, s1, ia1, fa1);
    drawArc(x2, y2, s2, fa2, ia2);
    endShape();
  } else {
    ellipse(x1, y1, s1, s1);
  }
}


float k = (4./3.)*(sqrt(2.)-1);
void drawArc(float x, float y, float s, float ia, float fa) {
  float r = s*0.5;
  float totalAngle = abs(ia-fa);
  if (totalAngle > TWO_PI*2) totalAngle = totalAngle%TWO_PI + TWO_PI;
  float sign = (ia > fa)? -1 : 1;
  float ang = ia;

  while (totalAngle >= HALF_PI) {
    float a1 = ang;
    float a2 = ang+HALF_PI*sign;

    float x1 = x+cos(a1)*r;
    float y1 = y+sin(a1)*r;
    float x4 = x+cos(a2)*r;
    float y4 = y+sin(a2)*r;

    float x2 = x1+cos(a2)*k*r;
    float y2 = y1+sin(a2)*k*r;
    float x3 = x4+cos(a1)*k*r;
    float y3 = y4+sin(a1)*k*r;

    vertex(x1, y1);
    bezierVertex(x2, y2, x3, y3, x4, y4);

    ang += HALF_PI*sign;
    totalAngle -= HALF_PI;
  }

  if (totalAngle > 0) {
    float amp = map(totalAngle, 0, HALF_PI, 0, 1);
    float a1 = ang;
    float a2 = ang+totalAngle*sign;

    float x1 = x+cos(a1)*r;
    float y1 = y+sin(a1)*r;
    float x4 = x+cos(a2)*r;
    float y4 = y+sin(a2)*r;

    float x2 = x1+cos(a1+HALF_PI*sign)*k*r*amp;
    float y2 = y1+sin(a1+HALF_PI*sign)*k*r*amp;
    float x3 = x4+cos(a2-HALF_PI*sign)*k*r*amp;
    float y3 = y4+sin(a2-HALF_PI*sign)*k*r*amp;

    vertex(x1, y1);
    bezierVertex(x2, y2, x3, y3, x4, y4);
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