

void rndCircularBack() {
  int cc = int(random(4, 38*random(1)))*2;
  float dx = (random(1) < 0.8)? 0 : random(-0.6, 0.6);
  float dy = (random(1) < 0.6)? 0 : random(-0.6, 0.6);
  float amp = random(0.5-random(0.3), 0.5+random(0.3));
  int sub = int(random(1, random(-4, 6)));
  float subAmp = random(0.4, 1);
  boolean halo = (random(1) < 1);
  float haloAmp = random(1.1, 1.5);
  float haloAlp = random(256*random(0.5, 0.9));

  circularAmount.setValue(cc);
  circularDesxAmount.setValue(dx);
  circularDesyAmount.setValue(dy);
  circularAmplitud.setValue(amp);

  circularSub.setValue(sub);
  circularSubAmplitud.setValue(subAmp);
  circularHalo.setValue(halo);
  circularHaloAmplitud.setValue(haloAmp);
  circularHaloAlpha.setValue(haloAlp);

  //circularBack(render, cc, dx, dy, amp, sub, subAmp, halo, haloAmp, haloAlp);
}


void circularBack(PGraphics render) {
  int cc = (int) circularAmount.getValue();
  float dx = circularDesxAmount.getValue();
  float dy = circularDesyAmount.getValue();
  float amp = circularAmplitud.getValue();
  int sub = (int)circularSub.getValue();
  float subAmp = circularSubAmplitud.getValue();
  boolean halo =  circularHalo.getValue();
  float haloAmp = circularHaloAmplitud.getValue();
  float haloAlp =  circularHaloAlpha.getValue();

  circularBack(render, cc, dx, dy, amp, sub, subAmp, halo, haloAmp, haloAlp);
}

void circularBack(PGraphics render, int cc, float dx, float dy, float amp, int sub, float subAmp, boolean halo, float haloAmp, float haloAlp) {
  float cx = render.width*0.5;
  float cy = render.height*0.5;
  float dd = max(render.width, render.height);

  dx *= render.width;
  dy *= render.height;
  float da = TWO_PI/cc;
  float ma = amp/2;
  if (sub == 1) subAmp = 1;

  render.noStroke();
  render.fill(colors[1]);
  for (int i = 0; i < cc; i++) {

    if (halo) {
      render.fill(colors[1], haloAlp);
      float a1 = da*(i-ma*haloAmp);
      float a2 = da*(i+ma*haloAmp);
      render.beginShape();
      render.vertex(cx+dx, cy+dy);
      render.vertex(cx+cos(a1)*dd, cy+sin(a1)*dd);
      render.vertex(cx+cos(a2)*dd, cy+sin(a2)*dd);
      render.endShape(CLOSE);
    }

    if (sub == 1) {
      render.fill(colors[1]);
      float a1 = da*(i-ma);
      float a2 = da*(i+ma);
      render.beginShape();
      render.vertex(cx+dx, cy+dy);
      render.vertex(cx+cos(a1)*dd, cy+sin(a1)*dd);
      render.vertex(cx+cos(a2)*dd, cy+sin(a2)*dd);
      render.endShape(CLOSE);
    } else {
      float ia = da*(i-ma);
      float fa = da*(i+ma);
      float ta = fa-ia;
      float sd = ta/sub;
      float sa = sd*subAmp;
      sd += ((sd-sa)/(sub-1));
      render.fill(colors[1]);
      for (int j = 0; j < sub; j++) {
        float a1 = ia+sd*j;
        float a2 = ia+sd*j+sa;
        render.beginShape();
        render.vertex(cx+dx, cy+dy);
        render.vertex(cx+cos(a1)*dd, cy+sin(a1)*dd);
        render.vertex(cx+cos(a2)*dd, cy+sin(a2)*dd);
        render.endShape(CLOSE);
      }
    }
  }
}

void rndHexBack() {  
  float ss = random(60, 320);
  boolean triangles = (random(1) < 0.5);
  boolean second = (random(1) < 0.5);
  float amp = random(0.4, 1);
  float amp2 = random(0.4, 1);
  float str1 = random(0.5)*random(1);
  float str2 = random(0.5)*random(1);
  float str3 = random(0.5)*random(1)*random(1);

  hexSize.setValue(ss);
  hexAmplitud.setValue(amp);
  hexAmplitud2.setValue(amp2);
  hexTriangles.setValue(triangles);
  hexSecond.setValue(second);

  hexStroke1.setValue(str1);
  hexStroke2.setValue(str2);
  hexStrokeTriangle.setValue(str3);

  //hexBack(render, ss, triangles, second, amp, amp2);
}


void hexBack(PGraphics render) {
  float ss = hexSize.getValue();
  float amp = hexAmplitud.getValue();
  float amp2 = hexAmplitud2.getValue();

  boolean triangles = hexTriangles.getValue();
  boolean second = hexSecond.getValue();

  float str1 = hexStroke1.getValue();
  float str2 = hexStroke2.getValue();
  float str3 = hexStrokeTriangle.getValue();

  hexBack(render, ss, triangles, second, amp, amp2, str1, str2, str3);
}

void hexBack(PGraphics render, float ss, boolean triangles, boolean second, float amp, float amp2, float str1, float str2, float str3) {

  float cx = render.width*0.5;
  float cy = render.height*0.5;

  float dx = ss * 2 * (3./4);
  float dy = (sqrt(3)*ss)/4;
  int cw = int(render.width/dx)+2;
  int ch = int(render.height/dy)+2;

  str1 *= 0.2*ss;
  str2 *= 0.2*ss;
  str3 *= 0.2*ss;

  render.noFill();
  for (int j = -ch/2; j <= ch/2; j++) {
    for (int i = -cw/2; i <= cw/2; i++) {
      float x = cx+((j%2==0)? i : i+0.5)*dx;
      float y = cy+j*dy;
      render.strokeWeight(str3);
      render.stroke(#b49f55);
      //fill(0);
      //hex(x, y, ss);
      if (triangles) hexTri(render, x, y, ss);

      render.strokeWeight(str1);
      render.noFill();
      hex(render, x, y, ss*amp);

      if (second) {
        float ang = PI/3;
        float x1 = x+ss*cos(ang)*0.5;
        float y1 = y+ss*sin(ang)*0.5;
        render.strokeWeight(str2);
        render.stroke(#b49f55);
        hex(render, x1, y1, ss*amp);
        render.strokeWeight(str3);
        hex(render, x1, y1, ss*amp2);
      }
    }
  }
}

void hex(PGraphics render, float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  render.beginShape();
  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    render.vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  render.endShape(CLOSE);
}

void hexTri(PGraphics render, float x, float y, float s) {
  float r = s*0.5;
  float da = TWO_PI/6;

  for (int i = 0; i < 6; i++) {
    float ang = da*i;  
    float ang2 = da*(i+1);  
    render.beginShape();
    render.vertex(x, y);
    render.vertex(x+cos(ang)*r, y+sin(ang)*r);
    render.vertex(x+cos(ang2)*r, y+sin(ang2)*r);
    render.endShape(CLOSE);
  }
}

void rndTramaBack() {  
  int cc = int(random(1, 7));
  float sep = random(4, random(60));
  float ia = random(TWO_PI);
  float minStr = random(0.4)*random(0.9);
  float maxStr = random(0.4)*random(0.5, 1);

  float bw = random(-0.1, 0.2);
  float bh = random(-0.1, 0.2);
  float bb = random(0.5, 1);

  int ps = int(random(1, random(6)));

  tramaAmount.setValue(cc);
  tramaSeparation.setValue(sep);
  tramaAngle.setValue(ia);
  tramaMinStroke.setValue(minStr);
  tramaMaxStroke.setValue(maxStr);

  tramaBorderWidth.setValue(bw);
  tramaBorderHeight.setValue(bh);
  tramaBorder.setValue(bb);
  tramaPISub.setValue(ps);

  //tramaBack(render, cc, sep, ia, minStr, maxStr, bw, bh, bb, ps);
}

void tramaBack(PGraphics render) {
  int cc = (int)tramaAmount.getValue();
  float sep = tramaSeparation.getValue();
  float ia = tramaAngle.getValue();
  float minStr = tramaMinStroke.getValue();
  float maxStr = tramaMaxStroke.getValue();

  float bw = tramaBorderWidth.getValue();
  float bh = tramaBorderHeight.getValue();
  float bb = tramaBorder.getValue();

  int ps = (int)tramaPISub.getValue();

  tramaBack(render, cc, sep, ia, minStr, maxStr, bw, bh, bb, ps);
}

void tramaBack(PGraphics render, int cc, float sep, float ia, float minStr, float maxStr, float bw, float bh, float bb, int ps) {

  float cx = render.width*0.5;
  float cy = render.height*0.5;
  float diag = dist(0, 0, render.width, render.height);
  float da = (TWO_PI/ps)/cc;

  bw *= render.width;
  bh *= render.height;
  minStr *= sep;
  maxStr *= sep;

  for (int j = 0; j < cc; j++) {
    float ang = ia+da*j;
    render.stroke(colors[1]);
    float sx = cos(ang+HALF_PI);
    float sy = sin(ang+HALF_PI);
    float dx = cos(ang)*diag;
    float dy = sin(ang)*diag;
    for (float i = -diag/2.; i < diag/2; i+=sep) {
      float x1 = cx-dx-sx*i;
      float y1 = cy-dy-sy*i;
      float x2 = cx+dx-sx*i;
      float y2 = cy+dy-sy*i;
      Line line = lineIntersectionRect(new PVector(x1, y1), new PVector(x2, y2), new PVector(bw, bh), new PVector(render.width-bw*2, render.height-bh*2));
      if (line != null) {
        render.strokeWeight(map(abs(i), 0, diag/2, minStr, maxStr));
        render.line(line.p1.x, line.p1.y, line.p2.x, line.p2.y);
      }
    }
  }


  render.noFill();
  render.strokeWeight(sep*bb);
  render.rect(bw, bh, render.width-bw*2, render.height-bh*2);
}

class Line {
  PVector p1, p2;   
  Line(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  Line(float x1, float y1, float x2, float y2) {
    this(new PVector(x1, y1), new PVector(x2, y2));
  }
}

PVector segmetnsIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float A1 = y2-y1;
  float B1 = x1-x2;
  float C1 = A1*x1+B1*y1;

  float A2 = y4-y3;
  float B2 = x3-x4;
  float C2 = A2*x3+B2*y3;

  float delta = A1*B2 - A2*B1;
  if (delta == 0)
    return null;

  float nx = (B2*C1 - B1*C2)/delta;
  float ny = (A1*C2 - A2*C1)/delta;

  //if (abs(dist(nx, ny, x1, y1)+dist(nx, ny, x2, y2)-dist(x1, y1, x2, y2)) < 0.000001 && abs(dist(nx, ny, x3, y3)+dist(nx, ny, x4, y4)-dist(x3, y3, x4, y4)) < 0.000001) {
  if (((abs(x1-nx)+abs(nx-x2))-abs(x1-x2) < 0.001) && ((abs(y1-ny)+abs(ny-y2))-abs(y1-y2) < 0.001)) {
    //if (pointInRect(nx, ny, min(x1, x2), min(y1, y2), abs(x1-x2), abs(y1-y2)) && pointInRect(nx, ny, min(x3, x4), min(y3, y4), abs(x3-x4), abs(y3-y4))) {
    return new PVector(nx, ny);
  }
  return null;
}

PVector segmetnsIntersection(PVector li1, PVector lf1, PVector li2, PVector lf2) {
  return segmetnsIntersection(li1.x, li1.y, lf1.x, lf1.y, li2.x, li2.y, lf2.x, lf2.y);
}

Line lineIntersectionRect(PVector p1, PVector p2, PVector rp, PVector s) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  if (p1.x >= rp.x && p1.x < rp.x+s.x && p1.y >= rp.y && p1.y < rp.y+s.y) {
    points.add(p1);
  }
  if (p2.x >= rp.x && p2.x < rp.x+s.x && p2.y >= rp.y && p2.y < rp.y+s.y) {
    points.add(p2);
  }

  if (points.size() < 2) {
    Line lines[] = new Line[4];
    lines[0] = new Line(rp.x, rp.y, rp.x+s.x, rp.y);
    lines[1] = new Line(rp.x+s.x, rp.y, rp.x+s.x, rp.y+s.y);
    lines[2] = new Line(rp.x+s.x, rp.y+s.y, rp.x, rp.y+s.y);
    lines[3] = new Line(rp.x, rp.y+s.y, rp.x, rp.y);

    for (int i = 0; i < 4; i++) {
      PVector aux = segmetnsIntersection(lines[i].p1, lines[i].p2, p1, p2);
      if (aux != null) {
        points.add(aux);
      }
    }
  }

  if (points.size() >= 2) {
    return new Line(points.get(0), points.get(1));
  }

  return null;
}

void rndRhombusBack() {
  float sw = random(20, random(500));
  float sh = random(20, random(500));
  int sub1 = int(random(1, random(20)));
  int sub2 = int(random(1, random(20)));

  rhombusBackSizeWidth.setValue(sw);
  rhombusBackSizeHeight.setValue(sh);
  rhombusBackSubdivision1.setValue(sub1);
  rhombusBackSubdivision2.setValue(sub2);
}

void rhombusBack(PGraphics render) {
  float sw = rhombusBackSizeWidth.getValue();
  float sh = rhombusBackSizeHeight.getValue();
  int sub1 = (int)rhombusBackSubdivision1.getValue();
  int sub2 = (int)rhombusBackSubdivision2.getValue();

  rhombusBack(render, sw, sh, sub1, sub2);
}

void rhombusBack(PGraphics render, float sw, float sh, int sub1, int sub2) {

  float cx = render.width*0.5;
  float cy = render.height*0.5;

  int cw = int((render.width/sw)/2)+1;
  int ch = int((render.height/sh)/2)+1;

  render.stroke(colors[1]);
  render.strokeWeight(2);
  render.noFill();
  for (int j = -ch; j <= ch; j++) {
    for (int i = -cw; i <= cw; i++) {
      float x = cx+(i+(j%2)*0.5)*sw;
      float y = cy+j*sh;
      render.stroke(colors[1]);
      render.noFill();
      int sc = 0;
      int sub = sub1;
      if ((abs(i)+abs(j))%2 == abs(i)%2) {
        sc = 1;
        sub = sub2;
      }
      render.noStroke();
      for (int k = 0; k < sub; k++) {
        float a = map(k, 0, sub, 1, 0);
        render.fill((k%2== sc)? colors[1] : colors[0]);
        render.beginShape();
        render.vertex(x, y-sh*a);
        render.vertex(x-sw*a/2, y);
        render.vertex(x, y+sh*a);
        render.vertex(x+sw*a/2, y);
        render.endShape(CLOSE);
      }
    }
  }
}

void rndRandomBack() {
  float minSize = random(1)*random(0.1, 1);
  float maxSize = random(100, 500);
  float amp1 = random(0.8, 1);
  float amp2 = random(0.8);
  float str = random(10);
  int form = int(random(3));
  int seed = int(random(9999999));

  randomBackMinSize.setValue(minSize);
  randomBackMaxSize.setValue(maxSize);
  randomBackAmplitud1.setValue(amp1);
  randomBackAmplitud2.setValue(amp2);
  randomBackStroke.setValue(str);
  randomBackForm.setValue(form);
  randomBackSeed.setValue(seed);
}

void randomBack(PGraphics render) {

  float minSize = randomBackMinSize.getValue();
  float maxSize = randomBackMaxSize.getValue();
  float amp1 = randomBackAmplitud1.getValue();
  float amp2 = randomBackAmplitud2.getValue();
  float str = randomBackStroke.getValue();
  int form = (int) randomBackForm.getValue();
  int seed = (int) randomBackSeed.getValue();

  randomBack(render, minSize, maxSize, amp1, amp2, str, form, seed);
}

void randomBack(PGraphics render, float minSize, float maxSize, float amp1, float amp2, float str, int form, int seed) {

  minSize *= maxSize;

  ArrayList<PVector> circles = new ArrayList<PVector>();

  Random rand = new Random();
  rand.setSeed(seed);
  for (int i = 0; i < 100000; i++) {
    PVector c = new PVector(rand.nextFloat()*render.width, rand.nextFloat()*render.height, minSize+rand.nextFloat()*(maxSize-minSize));
    boolean add = true;
    for (int j = 0; j < circles.size(); j++) {
      PVector aux = circles.get(j);
      if (dist(aux.x, aux.y, c.x, c.y) < (c.z+aux.z)/2) {
        add = false;
        break;
      }
    }
    if (add) circles.add(c);
  }

  float dd = 0.2+ rand.nextFloat()*0.5;
  int cc = int(4+rand.nextFloat()*8);
  for (int i = 0; i < circles.size(); i++) {
    PVector c = circles.get(i);


    render.noStroke();
    render.fill(colors[1]);
    //, float amp, int cc, float ang
    if (form == 0) render.ellipse(c.x, c.y, c.z*amp2, c.z*amp2);
    if (form == 1) star(render, c.x, c.y, c.z*amp2, dd, cc, rand.nextFloat()*TWO_PI);
    if (form == 2) moon(render, c.x, c.y, c.z*amp2, -1+rand.nextFloat()*2);

    render.noFill();
    render.stroke(colors[1]);
    render.strokeWeight(str);
    render.ellipse(c.x, c.y, c.z*amp1, c.z*amp1);
  }
}