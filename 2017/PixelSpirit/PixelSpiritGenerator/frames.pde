void rndSimpleFrame() {
  int cc = int(random(1, 9));
  float sep = random(4, 100);
  float ib = random(20);
  float str = random(8);
  float bor = random(0, random(40, 300));
  int type = int(random(5)); 

  simpleFrameAmount.setValue(cc);
  simpleFrameSeparation.setValue(sep);
  simpleFrameInternalBorder.setValue(ib);

  simpleFrameStroke.setValue(str);
  simpleFrameCornes.setValue(bor);
  simpleFrameType.setValue(type);
}

void simpleFrame(PGraphics render) {
  float sw = WIDTH-SAFE_WIDTH_IN*DPI;
  float sh = HEIGHT-SAFE_HEIGHT_IN*DPI;

  int cc = (int)simpleFrameAmount.getValue();
  float sep = simpleFrameSeparation.getValue();
  float ib = simpleFrameInternalBorder.getValue();

  float str = simpleFrameStroke.getValue();
  float bor = simpleFrameCornes.getValue();
  int type = simpleFrameType.getValue();

  simpleFrame(render, sw, sh, cc, sep, ib, str, bor, type);
}

void simpleFrame(PGraphics render, float sw, float sh, int cc, float sep, float ib, float str, float bor, int type) {
  //type 0 rect, 1 triangle, 2 quadr, 3 curve, 4 curveinv;

  if (cc == 1) sep = 0;
  float x1 = sw+sep+ib;
  float y1 = sh+sep+ib;
  float x2 = render.width-sw-sep-ib;
  float y2 = render.height-sh-sep-ib;
  float bb = bor;
  float crn = bb*kappa;

  render.noStroke();
  render.fill(colors[0]);
  render.beginShape();
  render.vertex(-2, -2);
  render.vertex(render.width/2+1, -2);
  render.vertex(render.width/2, y1);

  if (type != 0) render.vertex(x1+bb, y1);
  if (type == 0) render.vertex(x1, y1);
  if (type == 2) render.vertex(x1+bb, y1+bb);
  if (type == 3) render.bezierVertex(x1+bb-crn, y1, x1, y1+bb-crn, x1, y1+bb);
  if (type == 4) render.bezierVertex(x1+bb, y1+crn, x1+crn, y1+bb, x1, y1+bb);
  if (type != 0 && type != 3 && type != 4) render.vertex(x1, y1+bb);

  if (type != 0) render.vertex(x1, y2-bb);
  if (type == 0) render.vertex(x1, y2);
  if (type == 2) render.vertex(x1+bb, y2-bb);
  if (type == 3) render.bezierVertex(x1, y2-bb+crn, x1+bb-crn, y2, x1+bb, y2);
  if (type == 4) render.bezierVertex(x1+crn, y2-bb, x1+bb, y2-crn, x1+bb, y2);
  if (type != 0 && type != 3 && type != 4) render.vertex(x1+bb, y2);

  if (type != 0) render.vertex(x2-bb, y2);
  if (type == 0) render.vertex(x2, y2);
  if (type == 2) render.vertex(x2-bb, y2-bb);
  if (type == 3) render.bezierVertex(x2-bb+crn, y2, x2, y2-bb+crn, x2, y2-bb);
  if (type == 4) render.bezierVertex(x2-bb, y2-crn, x2-crn, y2-bb, x2, y2-bb);
  if (type != 0 && type != 3 && type != 4) render.vertex(x2, y2-bb);

  if (type != 0) render.vertex(x2, y1+bb);
  if (type == 0) render.vertex(x2, y1);
  if (type == 2) render.vertex(x2-bb, y1+bb);
  if (type == 3) render.bezierVertex(x2, y1+bb-crn, x2-bb+crn, y1, x2-bb, y1);
  if (type == 4) render.bezierVertex(x2-crn, y1+bb, x2-bb, y1+crn, x2-bb, y1);
  if (type != 0 && type != 3 && type != 4) render.vertex(x2-bb, y1);
  //

  render.vertex(render.width/2-2, y1);
  render.vertex(render.width/2, -2);
  render.vertex(render.width+1, -2);
  render.vertex(render.width+2, render.height+2);
  render.vertex(-2, render.height+2);
  render.endShape(CLOSE);

  if (str > 1) {
    for (int i = 0; i < cc; i++) {
      float dd = 0;
      if (cc > 1) dd = map(i, 0, cc-1, 0, sep);

      x1 = sw+dd;
      y1 = sh+dd;
      x2 = render.width-sw-dd;
      y2 = render.height-sh-dd;
      bb = bor;
      crn = bb*kappa;
      render.noFill();
      render.stroke(colors[1]);
      render.strokeWeight(str);
      render.beginShape();
      if (type != 0) render.vertex(x1+bb, y1);
      if (type == 0) render.vertex(x1, y1);
      if (type == 2) render.vertex(x1+bb, y1+bb);
      if (type == 3) render.bezierVertex(x1+bb-crn, y1, x1, y1+bb-crn, x1, y1+bb);
      if (type == 4) render.bezierVertex(x1+bb, y1+crn, x1+crn, y1+bb, x1, y1+bb);
      if (type != 0 && type != 3 && type != 4) render.vertex(x1, y1+bb);

      if (type != 0) render.vertex(x1, y2-bb);
      if (type == 0) render.vertex(x1, y2);
      if (type == 2) render.vertex(x1+bb, y2-bb);
      if (type == 3) render.bezierVertex(x1, y2-bb+crn, x1+bb-crn, y2, x1+bb, y2);
      if (type == 4) render.bezierVertex(x1+crn, y2-bb, x1+bb, y2-crn, x1+bb, y2);
      if (type != 0 && type != 3 && type != 4) render.vertex(x1+bb, y2);

      if (type != 0) render.vertex(x2-bb, y2);
      if (type == 0) render.vertex(x2, y2);
      if (type == 2) render.vertex(x2-bb, y2-bb);
      if (type == 3) render.bezierVertex(x2-bb+crn, y2, x2, y2-bb+crn, x2, y2-bb);
      if (type == 4) render.bezierVertex(x2-bb, y2-crn, x2-crn, y2-bb, x2, y2-bb);
      if (type != 0 && type != 3 && type != 4) render.vertex(x2, y2-bb);

      if (type != 0) render.vertex(x2, y1+bb);
      if (type == 0) render.vertex(x2, y1);
      if (type == 2) render.vertex(x2-bb, y1+bb);
      if (type == 3) render.bezierVertex(x2, y1+bb-crn, x2-bb+crn, y1, x2-bb, y1);
      if (type == 4) render.bezierVertex(x2-crn, y1+bb, x2-bb, y1+crn, x2-bb, y1);
      if (type != 0 && type != 3 && type != 4) render.vertex(x2-bb, y1);
      render.endShape(CLOSE);
    }
  }
}

void linearBorder(PGraphics render) {
  float sw = WIDTH-SAFE_WIDTH_IN*DPI;
  float sh = HEIGHT-SAFE_HEIGHT_IN*DPI;

  int cc = int(random(1, 5));
  float bb = max(sw, sh);
  float sep = random(4, 40);
  boolean inv = random(1) < 0.5;
  float ss = sep*(cc-1);
  float str = sep*random(0.5);

  simpleFrame(render, sw+ss, sh+ss, 0, 0, 0, 0, 0, 0);

  render.strokeWeight(str);
  render.noFill();
  render.stroke(colors[1]);
  for (int i = 0; i < cc; i++) {
    float dx = bb+sep*(i);
    float dy = bb+sep*(i);
    if (inv) dy = bb+sep*(cc-i-1);
    render.rect(dx, dy, render.width-dx*2, render.height-dy*2);
  }
}

void rndDoubleFrame() {
  float in = random(100);
  float ib = random(20);
  float str1 = random(8);
  float bor1 = random(0, random(40, 300));
  int type1 = int(random(5)); 
  float str2 = random(8);
  float bor2 = random(0, random(40, 300));
  int type2 = int(random(5)); 

  doubleFrameInside.setValue(in);
  doubleFrameInternalBorder.setValue(ib);

  doubleFrameStroke1.setValue(str1);
  doubleFrameCornes1.setValue(bor1);
  doubleFrameType1.setValue(type1);

  doubleFrameStroke2.setValue(str2);
  doubleFrameCornes2.setValue(bor2);
  doubleFrameType2.setValue(type2);
}

void doubleBorder(PGraphics render) {
  float sw = WIDTH-SAFE_WIDTH_IN*DPI;
  float sh = HEIGHT-SAFE_HEIGHT_IN*DPI;

  float in = doubleFrameInside.getValue();
  float ib = doubleFrameInternalBorder.getValue();

  float str1 = doubleFrameStroke1.getValue();
  float bor1 = doubleFrameCornes1.getValue();
  int type1 = doubleFrameType1.getValue();

  float str2 = doubleFrameStroke2.getValue();
  float bor2 = doubleFrameCornes2.getValue();
  int type2 = doubleFrameType2.getValue();

  doubleBorder(render, sw, sh, in, ib, str1, bor1, type1, str2, bor2, type2);
}


void doubleBorder(PGraphics render, float sw, float sh, float in, float ib, float str1, float bor1, int type1, float str2, float bor2, int type2) {
  simpleFrame(render, sw+in, sh+in, 1, 0, ib, str1, bor1, type1); 
  simpleFrame(render, sw, sh, 1, 0, 0, str2, bor2, type2);
}

void rndGuardaFrame() {
  float in = random(240);
  float bb = random(0.1, 0.6);
  float rou1 = random(0.5);
  float rou2 = random(0.5);
  float s1 = random(1);
  float s2 = random(1);
  boolean fill = (random(1) < 0.5);
  int form = int(random(3));
  int seed = int(random(9999999));

  guardaFrameInside.setValue(in);
  guardaFrameBorder.setValue(bb);
  guardaFrameRound1.setValue(rou1);
  guardaFrameRound2.setValue(rou2);
  guardaFrameSize1.setValue(s1);
  guardaFrameSize2.setValue(s2);
  guardaFrameFill.setValue(fill);
  guardaFrameForm.setValue(form);
  guardaFrameSeed.setValue(seed);
}

void guardaFrame(PGraphics render) {
  float sw = WIDTH-SAFE_WIDTH_IN*DPI;
  float sh = HEIGHT-SAFE_HEIGHT_IN*DPI;

  float in = guardaFrameInside.getValue();
  float bb = guardaFrameBorder.getValue();
  float rou1 = guardaFrameRound1.getValue();
  float rou2 = guardaFrameRound2.getValue();
  float s1 = guardaFrameSize1.getValue();
  float s2 = guardaFrameSize2.getValue();
  boolean fill = guardaFrameFill.getValue();
  int form = (int) guardaFrameForm.getValue();
  int seed = (int) guardaFrameSeed.getValue();

  guardaFrame(render, sw, sh, in, bb, rou1, rou2, s1, s2, fill, seed, form);
}

void guardaFrame(PGraphics render, float sw, float sh, float in, float bb, float rou1, float rou2, float s1, float s2, boolean fill, int seed, int form) {

  bb *= in;
  rou1 *= in;
  rou2 *= bb;

  int cw = int(ceil((render.width-sw*2)/bb)-1);
  int ch = int(ceil((render.height-sh*2)/bb)-1);

  simpleFrame(render, sw+in/2, sh+in/2, 1, 0, 0, 0, 0, 0); 

  Random rand = new Random();
  rand.setSeed(seed);
  float dd = 0.2+ rand.nextFloat()*0.5;
  int cc = int(4+rand.nextFloat()*8);
  render.strokeWeight(2);
  render.rectMode(CENTER);
  for (int i = -cw/2+1; i < cw/2; i++) {
    float x = render.width/2+i*bb;
    float y1 = sh+in/2;
    float y2 = render.height-sh-in/2;
    render.stroke(colors[1]);
    render.fill(colors[0]);
    render.rect(x, y1, bb, bb, rou2);
    render.rect(x, y2, bb, bb, rou2);
    if (fill) {
      render.noStroke();
      render.fill(colors[1]);
    }

    if (form == 0) {
      render.ellipse(x, y1, bb*s1, bb*s1);
      render.ellipse(x, y2, bb*s1, bb*s1);
    }
    if (form == 1) {
      star(render, x, y1, bb*s1, dd, cc, random(TWO_PI));
      star(render, x, y2, bb*s1, dd, cc, random(TWO_PI));
    }
    if (form == 2) {
      moon(render, x, y1, bb*s1, random(-1, 1));
      moon(render, x, y2, bb*s1, random(-1, 1));
    }
  }
  for (int i = -ch/2+1; i < ch/2; i++) {
    float y = render.height/2+i*bb;
    float x1 = sw+in/2;
    float x2 = render.width-sw-in/2;
    render.stroke(colors[1]);
    render.fill(colors[0]);
    render.rect(x1, y, bb, bb, rou2);
    render.rect(x2, y, bb, bb, rou2);
    if (fill) {
      render.noStroke();
      render.fill(colors[1]);
    }

    if (form == 0) {
      render.ellipse(x1, y, bb*s1, bb*s1);
      render.ellipse(x2, y, bb*s1, bb*s1);
    }
    if (form == 1) {
      star(render, x1, y, bb*s1, dd, cc, random(TWO_PI));
      star(render, x2, y, bb*s1, dd, cc, random(TWO_PI));
    }
    if (form == 2) {
      moon(render, x1, y, bb*s1, random(-1, 1));
      moon(render, x2, y, bb*s1, random(-1, 1));
    }
  }
  render.stroke(colors[1]);
  render.fill(colors[0]);
  render.rectMode(CORNER);
  render.rect(sw, sw, in, in, rou1);
  render.rect(render.width-sw-in, sw, in, in, rou1);
  render.rect(render.width-sw-in, render.height-sh-in, in, in, rou1);
  render.rect(sw, render.height-sh-in, in, in, rou1);

  render.stroke(colors[1]);
  render.fill(colors[0]);
  if (fill) {
    render.noStroke();
    render.fill(colors[1]);
  }
  if (form == 0) {
    render.ellipse(sw+in*0.5, sh+in*0.5, in*s2, in*s2);
    render.ellipse(render.width-sw-in*0.5, sh+in*0.5, in*s2, in*s2);
    render.ellipse(render.width-sw-in*0.5, render.height-sh-in*0.5, in*s2, in*s2);
    render.ellipse(sw+in*0.5, render.height-sh-in*0.5, in*s2, in*s2);
    //render.ellipse(x2, y, bb*ss, bb*ss);
  }
  if (form == 1) {
    star(render, sw+in*0.5, sh+in*0.5, in*s2, dd, cc, random(TWO_PI));
    star(render, render.width-sw-in*0.5, sh+in*0.5, in*s2, dd, cc, random(TWO_PI));
    star(render, render.width-sw-in*0.5, render.height-sh-in*0.5, in*s2, dd, cc, random(TWO_PI));
    star(render, sw+in*0.5, render.height-sh-in*0.5, in*s2, dd, cc, random(TWO_PI));
  }
  if (form == 2) {
    moon(render, sw+in*0.5, sh+in*0.5, in*s2, random(-1, 1));
    moon(render, render.width-sw-in*0.5, sh+in*0.5, in*s2, random(-1, 1));
    moon(render, render.width-sw-in*0.5, render.height-sh-in*0.5, in*s2, random(-1, 1));
    moon(render, sw+in*0.5, render.height-sh-in*0.5, in*s2, random(-1, 1));
  }
}


void rndRectFrame() {
  float ib = random(10);
  float s = random(10, random(60));
  float s2 = random(s, s*3);
  int sub = int(random(1, random(8)));
  float str1 = random(0.5);
  float str2 = random(0.5);

  rectFrameInternalBorder.setValue(ib);
  rectFrameSize1.setValue(s);
  rectFrameSize2.setValue(s2);
  rectFrameSub.setValue(sub);
  rectFrameStroke1.setValue(str1);
  rectFrameStroke2.setValue(str2);
}

void rectFrame(PGraphics render) {
  float sw = WIDTH-SAFE_WIDTH_IN*DPI;
  float sh = HEIGHT-SAFE_HEIGHT_IN*DPI;

  float ib = rectFrameInternalBorder.getValue();
  float s = rectFrameSize1.getValue();
  float s2 = rectFrameSize2.getValue();
  int sub = (int)rectFrameSub.getValue();
  float str1 = rectFrameStroke1.getValue();
  float str2 = rectFrameStroke2.getValue();

  rectFrame(render, sw, sh, ib, s, s2, sub, str1, str2);
}

void rectFrame(PGraphics render, float sw, float sh, float ib, float s, float s2, int sub, float str1, float str2) {
  float x1 = sw+s/2;
  float x2 = render.width-sw-s/2;
  float y1 = sh+s/2;
  float y2 = render.height-sh-s/2;

  simpleFrame(render, sw+s2+s+ib, sh+s2+s+ib, 1, 0, 0, 0, 0, 0); 

  ArrayList<PVector> points = new ArrayList<PVector>();

  points.add(new PVector(x1, y1));
  points.add(new PVector(x1+s2, y1));
  points.add(new PVector(x1+s2, y2));
  points.add(new PVector(x1, y2));
  points.add(new PVector(x1, y2-s2));
  points.add(new PVector(x2, y2-s2));
  points.add(new PVector(x2, y2));
  points.add(new PVector(x2-s2, y2));
  points.add(new PVector(x2-s2, y1));
  points.add(new PVector(x2, y1));
  points.add(new PVector(x2, y1+s2));
  points.add(new PVector(x1, y1+s2));
  points.add(new PVector(x1, y1));
  points.add(new PVector(x1+s2, y1));

  drawLine(render, points, s, sub, str1, str2);
}


void drawLine(PGraphics render, ArrayList<PVector> points, float str, int sub, float str1, float str2) {
  float r = str*0.5;
  str1 *= 0.2;
  str2 *= 0.2;

  render.fill(colors[0]);
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
    render.stroke(colors[0]);

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

    render.beginShape();
    render.vertex(x1, y1);
    render.vertex(x2, y2);
    render.vertex(x3, y3);
    render.vertex(x4, y4);
    render.endShape();

    render.stroke(colors[1]);
    render.strokeWeight(max(1, r*str1));
    render.line(x4, y4, x1, y1);
    render.line(x2, y2, x3, y3);

    render.strokeWeight(max(1, r*str2));
    for (int j = 1; j <= sub; j++) {
      float ax1 = lerp(x1, x2, map(j, 0, sub+1, 0, 1));
      float ay1 = lerp(y1, y2, map(j, 0, sub+1, 0, 1));
      float ax2 = lerp(x4, x3, map(j, 0, sub+1, 0, 1));
      float ay2 = lerp(y4, y3, map(j, 0, sub+1, 0, 1));
      render.line(ax1, ay1, ax2, ay2);
    }


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

void rndQuadFrame() {
  float ss = random(4, 120);
  float str = random(10);
  float ib = random(40);
  boolean ext = random(1) < 0.5;
  float in = random(2)*random(1);
  boolean dou = random(1) < 0.5;

  quadFrameSize.setValue(ss);
  quadFrameStroke.setValue(str);
  quadFrameInternalBorder.setValue(ib);
  quadFrameRect.setValue(ext);
  quadFrameInside.setValue(in);
  quadFrameDouble.setValue(dou);
}

void quadFrame(PGraphics render) {
  float sw = WIDTH-SAFE_WIDTH_IN*DPI;
  float sh = HEIGHT-SAFE_HEIGHT_IN*DPI;

  float ss = quadFrameSize.getValue();
  ;
  float str = quadFrameStroke.getValue();
  float ib = quadFrameInternalBorder.getValue();
  boolean ext = quadFrameRect.getValue();
  float in = quadFrameInside.getValue();
  boolean dou = quadFrameDouble.getValue();

  quadFrame(render, sw, sh, ss, str, ib, ext, in, dou);
}


void quadFrame(PGraphics render, float sw, float sh, float ss, float str, float ib, boolean ext, float in, boolean dou) {

  float x1 = sw;
  float x2 = render.width-sw;
  float y1 = sh;
  float y2 = render.height-sh;

  if (ext) {
    x1 += ss*in;
    y1 += ss*in; 
    x2 -= ss*in;
    y2 -= ss*in;
  }

  ArrayList<PVector> points = new ArrayList<PVector>();
  points.add(new PVector(x1, y1+ss*2));
  points.add(new PVector(x1+ss, y1+ss*2));
  points.add(new PVector(x1+ss, y1));
  points.add(new PVector(x1, y1));
  points.add(new PVector(x1, y1+ss));
  points.add(new PVector(x1+ss*2, y1+ss));
  points.add(new PVector(x1+ss*2, y1));
  points.add(new PVector(x2-ss*2, y1));
  points.add(new PVector(x2-ss*2, y1+ss));
  points.add(new PVector(x2, y1+ss));
  points.add(new PVector(x2, y1));
  points.add(new PVector(x2-ss, y1));
  points.add(new PVector(x2-ss, y1+ss*2));
  points.add(new PVector(x2, y1+ss*2));
  points.add(new PVector(x2, y2-ss*2));
  points.add(new PVector(x2-ss, y2-ss*2));
  points.add(new PVector(x2-ss, y2));
  points.add(new PVector(x2, y2));
  points.add(new PVector(x2, y2-ss));
  points.add(new PVector(x2-ss*2, y2-ss));
  points.add(new PVector(x2-ss*2, y2));
  points.add(new PVector(x1+ss*2, y2));
  points.add(new PVector(x1+ss*2, y2-ss));
  points.add(new PVector(x1, y2-ss));
  points.add(new PVector(x1, y2));
  points.add(new PVector(x1+ss, y2));
  points.add(new PVector(x1+ss, y2-ss*2));
  points.add(new PVector(x1, y2-ss*2));

  render.fill(colors[0]);
  render.stroke(colors[0]);
  render.strokeWeight(str);
  render.beginShape();
  render.vertex(-2, -2);
  render.vertex(x1+ib, y1+ss*2+ib);
  render.vertex(x1+ss+ib, y1+ss*2+ib);
  render.vertex(x1+ss+ib, y1+ss+ib);
  render.vertex(x1+ss*2+ib, y1+ss+ib);
  render.vertex(x1+ss*2+ib, y1+ib);
  render.vertex(x2-ss*2-ib, y1+ib);
  render.vertex(x2-ss*2-ib, y1+ss+ib);
  render.vertex(x2-ss-ib, y1+ss+ib);
  render.vertex(x2-ss-ib, y1+ss*2+ib);
  render.vertex(x2-ib, y1+ss*2+ib);
  render.vertex(x2-ib, y2-ss*2-ib);
  render.vertex(x2-ss-ib, y2-ss*2-ib);
  render.vertex(x2-ss-ib, y2-ss-ib);
  render.vertex(x2-ss*2-ib, y2-ss-ib);
  render.vertex(x2-ss*2-ib, y2-ib);
  render.vertex(x1+ss*2+ib, y2-ib);
  render.vertex(x1+ss*2+ib, y2-ss-ib);
  render.vertex(x1+ss+ib, y2-ss-ib);
  render.vertex(x1+ss+ib, y2-ss*2-ib);
  render.vertex(x1+ib, y2-ss*2-ib);
  render.vertex(x1+ib, y1+ss*2-ib);
  render.vertex(-2, -2);
  render.vertex(-2, render.height+2);
  render.vertex(render.width+2, render.height+2);
  render.vertex(render.width+2, -2);
  render.vertex(-2, -2);
  render.endShape(CLOSE);


  render.noFill();
  render.stroke(colors[1]);
  render.strokeWeight(str*2);
  if (ext) render.rect(sw, sh, render.width-sw*2, render.height-sh*2);
  render.beginShape();
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    render.vertex(p.x, p.y);
  }
  render.endShape(CLOSE);

  if (dou) {
    render.stroke(colors[0]);
    render.strokeWeight(str);
    if (ext) render.rect(sw, sh, render.width-sw*2, render.height-sh*2);
    render.beginShape();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      render.vertex(p.x, p.y);
    }
    render.endShape(CLOSE);
  }
}