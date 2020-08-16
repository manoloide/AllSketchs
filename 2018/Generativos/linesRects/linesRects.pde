int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
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
  background(#D5DEE3);



  int ss = 5; 
  int anc = 8; 

  noFill();
  stroke(0, 2);
  for (int y = 0; y < height; y+= ss) {
    for (int x = 0; x < width; x+= ss) {
      rect(x, y, ss, ss);
    }
  }


  for (int c = 0; c < 8; c++) {

    ss = 5*int(pow(2, int(random(3)))); 

    int cw = int(width/ss)+1;
    int ch = int(height/ss)+1;

    float ia = random(TWO_PI);
    float an = 0;

    noStroke();
    float x = random(width);
    float y = random(height);
    float s2 = width*random(0.1, 1)*random(1);
    float s1 = s2*random(random(0.5, 0.8), random(0.8, 1));
    while (an < TWO_PI) {
      float aa = an;
      an += random(TWO_PI)*random(1)*random(0.5, 1);
      if (an > TWO_PI) an = TWO_PI;

      float shw = s2*0.2;
      arc2(x, y, s2, s2+shw, ia+aa, ia+an, color(0), 10, 0);
      arc2(x, y, s1, s1-shw, ia+aa, ia+an, color(0), 10, 0);
      shw = s2*0.08;
      arc2(x, y, s2, s2+shw, ia+aa, ia+an, color(0), 18, 0);
      arc2(x, y, s1, s1-shw, ia+aa, ia+an, color(0), 18, 0);

      fill(rcol());
      arc2(x, y, s1, s2, ia+aa, ia+an);
    }

    {
      int ccx = int(random(1, 8));
      int ccy = int(random(1, 8));
      x = int(random(cw));
      y = int(random(ch));
      rectShw(x*ss, y*ss, ccx*ss, ccy*ss, min(ccx*ss, ccy*ss)*0.2, 12);
      for (int j = 0; j < ccy; j++) {
        for (int i = 0; i < ccx; i++) {
          fill(rcol());
          rect((x+i)*ss, (y+j)*ss, ss, ss);
        }
      }
    }

    int cc = int(random(-5, 4));
    for (int i = 0; i < cc; i++) {
      int s = int(random(1, 6));
      x = int(random(cw));
      y = int(random(ch));
      rectShw(x*ss, y*ss, s*ss, s*ss, s*ss*0.2, 12);
      fill(rcol());
      rect(x*ss, y*ss, s*ss, s*ss);
    }

    int xx = cw/2;
    int yy = ch/2;
    int dir = int(random(4));

    if (dir == 0) xx = 0;
    if (dir == 1) yy = 0;
    if (dir == 2) xx = cw;
    if (dir == 3) yy = ch;


    ArrayList<PVector> points = new ArrayList<PVector>();
    points.add(new PVector(xx, yy));

    boolean in = true;
    while (in) {
      int dx = int(cos(dir*HALF_PI));
      int dy = int(sin(dir*HALF_PI));
      dir += int(random(2))*2-1;
      int des = anc/2+int(random(1, random(4, 18)));
      xx += dx*des;
      yy += dy*des;
      points.add(new PVector(xx, yy));

      if (xx < 0 || xx > cw || yy < 0 || yy > ch) in = false;
    }

    for (int i = 1; i < points.size(); i++) {
      PVector p1 = points.get(i-1);
      PVector p2 = points.get(i);

      float ang = atan2(p2.y-p1.y, p2.x-p1.x);

      int d1 = 0;
      int d2 = 0;

      if (i > 1) {
        PVector p0 = points.get(i-2);
        float ang2 = atan2(p0.y-p1.y, p0.x-p1.x);
        if (distance(ang, ang2) >= 0) d1 = 1;
      }
      if (i < points.size()-1) {
        PVector p3 = points.get(i+1);
        float ang2 = atan2(p2.y-p3.y, p2.x-p3.x);
        if (distance(ang, ang2) >= 0) d2 = 1;
      }

      float dx = cos(ang+HALF_PI)*ss*anc*0.25;
      float dy = sin(ang+HALF_PI)*ss*anc*0.25;

      float ux1 = cos(ang+PI*d1)*ss*anc*0.25;
      float uy1 = sin(ang+PI*d1)*ss*anc*0.25;
      float ux2 = cos(ang+PI*d2)*ss*anc*0.25;
      float uy2 = sin(ang+PI*d2)*ss*anc*0.25;

      if (i == 1) ux1 = uy1 = 0;
      if (i == points.size()-1) ux2 = uy2 = 0;

      int col = rcol();


      noStroke();

      beginShape();
      fill(col);
      vertex(p1.x*ss-dx+ux1, p1.y*ss-dy+uy1);
      vertex(p2.x*ss-dx+ux2, p2.y*ss-dy+uy2);
      fill(lerpColor(col, color(0), 0.1));
      vertex(p2.x*ss+dx-ux2, p2.y*ss+dy-uy2);
      vertex(p1.x*ss+dx-ux1, p1.y*ss+dy-uy1);
      endShape(CLOSE);

      if (d1 == 0) {
        float x1 = p1.x*ss+dx-ux1;
        float y1 = p1.y*ss+dy-uy1;
        float x2 = p1.x*ss+dx+ux1;
        float y2 = p1.y*ss+dy+uy1;
        float a = atan2(y2-y1, x2-x1)+HALF_PI;
        beginShape();
        fill(0, 30);
        vertex(x1, y1);
        vertex(x2, y2);
        fill(0, 0);
        vertex(x2+cos(a)*ss, y2+sin(a)*ss);
        vertex(x1+cos(a)*ss, y1+sin(a)*ss);
        endShape(CLOSE);
      }
      if (d1 == 1) {
        float x1 = p1.x*ss-dx+ux1;
        float y1 = p1.y*ss-dy+uy1;
        float x2 = p1.x*ss-dx-ux1;
        float y2 = p1.y*ss-dy-uy1;
        float a = atan2(y2-y1, x2-x1)-HALF_PI;
        beginShape();
        fill(0, 30);
        vertex(x1, y1);
        vertex(x2, y2);
        fill(0, 0);
        vertex(x2+cos(a)*ss, y2+sin(a)*ss);
        vertex(x1+cos(a)*ss, y1+sin(a)*ss);
        endShape(CLOSE);
      }
      //line(p1.x*ss, p1.y*ss, p2.x*ss, p2.y*ss);
    }
  }
}

void rectShw(float x, float y, float w, float h, float s, float shw) {
  beginShape();
  fill(0, shw);
  vertex(x, y);
  vertex(x+w, y);
  fill(0, 0);
  vertex(x+w+s, y-s);
  vertex(x-s, y-s);
  endShape();


  beginShape();
  fill(0, shw);
  vertex(x+w, y);
  vertex(x+w, y+h);
  fill(0, 0);
  vertex(x+w+s, y+h+s);
  vertex(x+w+s, y-s);
  endShape();

  beginShape();
  fill(0, shw);
  vertex(x+w, y+h);
  vertex(x, y+h);
  fill(0, 0);
  vertex(x-s, y+h+s);
  vertex(x+w+s, y+h+s);
  endShape();

  beginShape();
  fill(0, shw);
  vertex(x, y+h);
  vertex(x, y);
  fill(0, 0);
  vertex(x-s, y-s);
  vertex(x-s, y+h+s);
  endShape();
}

void arc2(float x, float y, float s1, float s2, float a1, float a2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
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


float distance(float a, float b) {
  float phi = abs(b - a)%TWO_PI;
  float distance = phi > 180 ? 360 - phi : phi;
  float sign = (a - b >= 0 && a - b <= PI) || (a - b <= -PI && a- b>= -TWO_PI) ? 1 : -1; 
  return distance*sign;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


int colors[] = {#18204a, #1aade2, #53a965, #FFD362, #ff752f, #ff5d64};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}