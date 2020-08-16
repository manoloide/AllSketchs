void basicBack() {

  ArrayList<PVector> points;
  ArrayList<Triangle> tris;

  int cc = 4000;
  //points = pointsCen(cc);
  points =  pointsUni(cc);
  tris = Triangulate.triangulate(points);

  noStroke();  
  if (tris != null) {
    PVector p1, p2, p3;
    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      p1 = t.p1;
      p2 = t.p2;
      p3 = t.p3;


      noFill();
      stroke(255, 10);
      fill(lerpColor(color(0), rcol(), random(1)*random(0.5, 1)));
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      endShape();

      float area = getAreaTri(p1, p2, p3);
      float r1, r2, s1, x, y;
      for (int j = 0; j < area*2.1; j++) {
        r1 = random(0.1, 1)*random(1)*random(0.5, 1);
        float dd = int(random(0, 2));
        r2 = random(dd*0.8, 1)*random(0.4, 1);
        stroke(int(r1*2)*255, 40);
        r1 = random(1);
        s1 = sqrt(r1);
        x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1;
        y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1;
        point(x, y);
      }
    }
  }
}

void spiderWeb() {  

  ArrayList<PVector> points;
  ArrayList<Triangle> tris;

  int cc = 200;
  points = pointsCen(cc);
  tris = Triangulate.triangulate(points);

  PVector p1, p2, p3, c1, c2, c3, i1, i2, i3, cen;
  float amp1 = random(0.1, 0.3)*random(0.06, 0.08);
  float amp2 = amp1*random(0.25);//0.01;
  int col = rcol();
  blendMode(ADD);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    p1 = t.p1;
    p2 = t.p2;
    p3 = t.p3;
    cen = p1.copy().add(p2).add(p3).div(3);
    i1 = PVector.lerp(p1, cen, amp1);
    i2 = PVector.lerp(p2, cen, amp1);
    i3 = PVector.lerp(p3, cen, amp1);
    c1 = p1.copy().add(p2).div(2).lerp(cen, amp2);
    c2 = p2.copy().add(p3).div(2).lerp(cen, amp2);
    c3 = p3.copy().add(p1).div(2).lerp(cen, amp2);

    int col2 = rcol();
    noStroke();
    beginShape();
    fill(col2, 250);
    vertex(p1.x, p1.y);
    fill(col2, 0);
    vertex(p2.x, p2.y);
    fill(col2, 0);
    vertex(p3.x, p3.y);
    endShape();

    noStroke();
    fill(col);
    beginShape();
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);
    vertex(p1.x, p1.y);
    vertex(c3.x, c3.y);
    vertex(i3.x, i3.y);
    vertex(c2.x, c2.y);
    vertex(i2.x, i2.y);
    vertex(c1.x, c1.y);
    vertex(i1.x, i1.y);
    vertex(c3.x, c3.y);
    vertex(p1.x, p1.y);
    vertex(c3.x, c3.y);
    endShape(CLOSE);
  }
  blendMode(BLEND);
}

void backGra(int c1, float a1, int c2, float a2) {
  beginShape();
  fill(c1, a1);
  vertex(0, 0);
  vertex(width, 0);
  fill(c2, a2);
  vertex(width, height);
  vertex(0, height);
  endShape();
}

void rock(float xx, float yy, float s, int cc) {

  ArrayList<PVector> points;
  ArrayList<Triangle> tris;

  //points = pointsCen(cc);
  points =  pointsCir(cc, xx, yy, s);
  tris = Triangulate.triangulate(points);

  if (tris != null) {
    PVector p1, p2, p3;
    float area, dd;
    float r1, r2, s1, x, y;
    int rc;
    float r = s*0.5;
    float det = random(0.01);
    float des = random(1000);
    for (int i = 0; i < tris.size(); i++) {
      Triangle t = tris.get(i);
      p1 = t.p1;
      p2 = t.p2;
      p3 = t.p3;


      noFill();
      stroke(255, 20);
      fill(rcol());
      beginShape();
      vertex(p1.x, p1.y);
      vertex(p2.x, p2.y);
      vertex(p3.x, p3.y);
      endShape(CLOSE);

      area = getAreaTri(p1, p2, p3);
      for (int j = 0; j < area*1.8; j++) {
        r1 = random(0.1, 1)*random(1)*random(0.5, 1);
        dd = int(random(0, 2));
        r2 = random(dd*0.8, 1)*random(0.4, 1);
        stroke(int(r1*2)*255, 40);
        r1 = random(1);
        s1 = sqrt(r1);
        x = p1.x*(1-s1)+p2.x*(1-r2)*s1+p3.x*r2*s1;
        y = p1.y*(1-s1)+p2.y*(1-r2)*s1+p3.y*r2*s1;
        point(x, y);
      }
      /*
      rc = rcol();
      noFill();
      stroke(255, 10);
      beginShape();
      fill(rc, noise(des+p1.x*det, des+p1.x*det)*255);
      vertex(p1.x, p1.y);
      fill(rc, noise(des+p2.x*det, des+p2.x*det)*255);
      vertex(p2.x, p2.y);
      fill(rc, noise(des+p3.x*det, des+p3.x*det)*255);
      vertex(p3.x, p3.y);
      endShape();
      */

      float ma = random(0.5);
      blendMode(ADD);
      beginShape();
      fill(rcol(), random(230, 255)*ma);
      vertex(p1.x, p1.y);
      fill(rcol(), random(230, 255)*ma);
      vertex(p2.x, p2.y);
      fill(rcol(), random(230, 255)*ma);
      vertex(p3.x, p3.y);
      endShape(CLOSE);
      blendMode(BLEND);
      
      
      float dis;
      blendMode(BLEND);
      beginShape();
      float cx = xx+r*0.5;
      float cy = yy-r*0.3;
      float am = 60;
      dis = pow(dist(cx, cy, p1.x, p1.y)/r, 2)*am;
      fill(0, dis);
      vertex(p1.x, p1.y);
      dis = pow(dist(cx, cy, p2.x, p2.y)/r, 2)*am;
      fill(0, dis);
      vertex(p2.x, p2.y);
      dis = pow(dist(cx, cy, p3.x, p3.y)/r, 2)*am;
      fill(0, dis);
      vertex(p3.x, p3.y);
      endShape(CLOSE);
      blendMode(BLEND);
    }
  }
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
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


void islands() {
  ArrayList<PVector> ps = new ArrayList<PVector>();
  for (int i = 0; i < 30; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(0.02, 0.3);
    ps.add(new PVector(x, y, s));
  }

  for (int i = 0; i < ps.size(); i++) {
    PVector p = ps.get(i);
    stroke(0, 5);
    arc2(p.x, p.y, 0, p.z*1.6, 0, TAU, color(0), 200, 0);
    rock(p.x, p.y, p.z, 30);
    noStroke();

    imageMode(CENTER);
    int pc = int(random(-3, 5));
    for (int j = 0; j < pc; j++) {
      float x = p.x+random(-0.3, 0.3)*p.z;//random(width);
      float y = p.y-random(0.1, 0.38)*p.z;//random(40, height)*random(0.4, 1);
      float sca = pow(map(y, 0, height, 0.1, 1), 1.2)*0.22;
      drawTipito(x, y, sca);
    }
  }

  drawConnections(ps);
}

void drawTipito(float x, float y, float sca) {
  PImage img = tipitos.getRnd();
  tint(rcol());
  image(img, x, y, img.width*sca, img.height*sca);
}

void drawConnections(ArrayList<PVector> ps) {
  stroke(255, 60);
  PVector p1, p2;
  float ms, dd;
  for (int j = 0; j < ps.size(); j++) {
    p2 = ps.get(j);
    for (int i = j+1; i < ps.size(); i++) {
      p1 = ps.get(i);
      ms = (p1.z+p2.z)*0.7;
      dd = p1.dist(p2);
      if (dd > ms) continue;
      line(p1.x, p1.y, p2.x, p2.y);
    }
  } 


  ms = 0.4;
  for (int i = 0; i < ps.size(); i++) {
    p1 = ps.get(i);
    noStroke();
    fill(255, 240);
    ellipse(p1.x, p1.y, p1.z*0.06*ms, p1.z*0.06*ms);
    stroke(255, 240);
    noFill();
    strokeWeight(p1.z*0.006);
    ellipse(p1.x, p1.y, p1.z*0.12*ms, p1.z*0.12*ms);

    stroke(255, 10);
    strokeWeight(1);
    ellipse(p1.x, p1.y, p1.z*1.1*ms, p1.z*1.1*ms);
  }
}

void randomTri(float x, float y, float s) {
  float r = s*0.5;
  beginShape();
  for (int i = 0; i < 3; i++) {
    float a = random(TAU);
    float d = r*sqrt(random(0.1, 1));
    vertex(x+cos(a)*d, y+sin(a)*d);
  }
  endShape(CLOSE);
}