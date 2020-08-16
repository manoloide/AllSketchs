
void rndCircularForm() { 

  int cc = int(random(random(2, 10), 33));
  float r = random(0.3, 0.44);
  float s = random(0.01, 1);
  float str = random(1)*random(1);
  int sub = int(random(3, random(10, 25)));
  int seed = int(random(9999999));

  circularFormAmount.setValue(cc);
  circularFormRadius.setValue(r);
  circularFormSize.setValue(s);
  circularFormStr.setValue(str);
  circularFormSub.setValue(sub);
  circularFormSeed.setValue(seed);

  //circularForm(render, cc, r, s, sub, seed);
}

void circularForm(PGraphics render) {
  int cc = (int)circularFormAmount.getValue();
  float r = circularFormRadius.getValue();
  float s = circularFormSize.getValue();
  float str = circularFormStr.getValue();
  int sub = (int)circularFormSub.getValue();
  int seed = (int)circularFormSeed.getValue();

  circularForm(render, cc, r, s, str, sub, seed);
}

void circularForm(PGraphics render, int cc, float r, float s, float str, int sub, int seed) {

  float cx = render.width*0.5;
  float cy = render.height*0.5;

  r *= max(render.width, render.height);
  s = (s*0.1)*r;

  float dr = r/sub;
  float da = TWO_PI/cc;

  Random rand = new Random();
  rand.setSeed(seed);

  render.noStroke();
  for (int j = 0; j < sub; j++) {
    float rr = dr*j;
    int dj = int(cc*rand.nextFloat()*rand.nextFloat()*map(j, 0, sub, 1, -0.2));
    if (j%2 == 0) {
      float ss = s*rand.nextFloat()*(rand.nextFloat()*0.5+0.5);
      for (int i = 0; i < cc; i++) {
        float x = cx+cos(da*i)*rr;
        float y = cy+sin(da*i)*rr;
        render.noStroke();
        render.fill(colors[1]);
        render.ellipse(x, y, ss, ss);

        if (j > 0 && dj >= 0) {
          render.strokeWeight(dr*0.2*str);
          render.stroke(colors[1]);

          float r2 = dr*(j-2);
          float x1 = cx+cos(da*(i+dj))*r2;
          float y1 = cy+sin(da*(i+dj))*r2;
          render.line(x, y, x1, y1);
          float x2 = cx+cos(da*(i-dj))*r2;
          float y2 = cy+sin(da*(i-dj))*r2;
          render.line(x, y, x2, y2);
        }
      }
    } else {
      render.noFill();
      render.stroke(colors[1]);
      render.strokeWeight(1+rand.nextFloat()*dr*0.5*str);
      render.ellipse(cx, cy, rr, rr);
    }
  }
}


void star(PGraphics render, float x, float y, float s, float amp, int cc, float ang) {
  float r1 = s*0.5;
  float r2 = r1*amp;
  float da = TWO_PI/(cc*2); 
  render.beginShape();
  for (int i = 0; i < cc*2; i++) {
    float a = ang+da*i;
    float r = (i%2== 0)? r1 : r2;
    render.vertex(x+cos(a)*r, y+sin(a)*r);
  }
  render.endShape(CLOSE);
}

void moon(PGraphics render, float x1, float y1, float s1, float amp) {
  float x2 = x1+map(amp, -1, 1, -s1*0.5, s1*0.5);
  float y2 = y1;//+map(abs(amp), 0, 1, 0, s1*0.3);
  float s2 = map(abs(amp), 0, 1, 1.2, 1)*s1;
  drawCircles(render, x1, y1, s1, x2, y2, s2);
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

void drawCircles(PGraphics render, float x1, float y1, float s1, float x2, float y2, float s2) {

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
    render.beginShape();
    drawArc(render, x1, y1, s1, ia1, fa1);
    drawArc(render, x2, y2, s2, fa2, ia2);
    render.endShape();
  } else {
    render.ellipse(x1, y1, s1, s1);
  }
}


float k = (4./3.)*(sqrt(2.)-1);
void drawArc(PGraphics render, float x, float y, float s, float ia, float fa) {
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

    render.vertex(x1, y1);
    render.bezierVertex(x2, y2, x3, y3, x4, y4);

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

    render.vertex(x1, y1);
    render.bezierVertex(x2, y2, x3, y3, x4, y4);
  }
}