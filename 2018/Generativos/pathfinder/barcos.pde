ArrayList<PVector> barcos;

ArrayList<PVector> boyas;

void barcos() {
  barcos = new ArrayList<PVector>();
  boyas = new ArrayList<PVector>();
  int cc = int(random(300, 800));
  for (int i = 0; i < cc; i++) {
    float x = random(-width, width);
    float y = random(-height, height); 
    float s = width*random(0.2);
    boolean add = true;
    float sca = 0.42;
    if (x >= -width*sca && x <= width*sca && y >= -height*sca && y <= height*sca) {
      add = false;
    }
    if (add) {
      for (int j = 0; j < barcos.size(); j++) {
        PVector other = barcos.get(j);
        float dis = dist(x, y, other.x, other.y);
        if (dis < (s+other.z)*0.5) {
          add = false;
          break;
        }
      }
    }
    if (add) barcos.add(new PVector(x, y, s));
  }

  for (int i = 0; i < barcos.size(); i++) {
    PVector b = barcos.get(i);

    pushMatrix();
    noFill();
    stroke(rcol(), 180);
    float a1 = random(TAU);
    float a2 = a1 + random(HALF_PI);
    strokeWeight(random(0.8, 2));
    arc(b.x, b.y, b.z*1, b.z*1, a1, a2);
    stroke(0, 20);
    strokeWeight(0.8);

    int c1 = rcol();
    int c2 = rcol();
    while (c1 == c2) c2 = rcol();
    fill(c1);
    ellipse(b.x, b.y, b.z*0.95, b.z*0.95);
    translate(0, 0, 0.2);
    fill(c2);
    ellipse(b.x, b.y, b.z*0.35, b.z*0.35);
    stroke(c1);
    line(b.x, b.y, 0, b.x, b.y, -b.z*0.58);
    noStroke();
    pushMatrix();
    translate(0, 0, -b.z*0.58);
    fill(c2, 180);
    ellipse(b.x, b.y, b.z*0.1, b.z*0.1);
    boyas.add(new PVector(b.x, b.y, -b.z*0.58));
    popMatrix();

    stroke(0, 20);
    if (random(1) < 0.99) {
      pushMatrix();
      fill(rcol());
      barco(b.x, b.y, b.z);

      int cubes = int(random(2, 5)*random(0.5, 1));
      ArrayList<PVector> positions = new ArrayList<PVector>();
      for (int k = 0; k < cubes; k++) {
        float s = b.z*0.05;
        float x = random(-b.z*0.25+s*0.2, +b.z*0.25-s*0.2);
        float y = random(-b.z*0.12+s*0.2, +b.z*0.12-s*0.2);

        boolean add = true;
        for (int l = 0; l < positions.size(); l++) {
          PVector other = positions.get(l);
          float dist = dist(x, y, other.x, other.y);
          if (dist < s*1.5) {
            add = false;
            break;
          }
        }
        if (add) {
          pushMatrix();
          translate(x, y, 0);
          rotate(random(TAU));
          fill(rcol());
          box(s);
          popMatrix();
          positions.add(new PVector(x, y, s));
        }
      }
      popMatrix();
    }
    popMatrix();



    strokeWeight(0.8);
    float des = -5000;
    stroke(0, 4);
    noFill();
    curve(b.x, b.y, -des, b.x, b.y, 0, 0, 0, 0, 0, 0, -des);
    strokeWeight(0.8);
  }

  ArrayList triangles = Triangulate.triangulate(barcos);
  stroke(255, 40);
  noFill();
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();

  triangles = Triangulate.triangulate(boyas);
  stroke(255, 80);
  beginShape(TRIANGLES);
  for (int i = 0; i < triangles.size(); i++) {
    if (random(1) < 0.9) continue;
    fill(rcol(), random(10, 60));
    Triangle t = (Triangle)triangles.get(i);
    vertex(t.p1.x, t.p1.y, t.p1.z);
    vertex(t.p2.x, t.p2.y, t.p1.z);
    vertex(t.p3.x, t.p3.y, t.p1.z);
  }
  endShape();
}

void barco(float x, float y, float s) {

  translate(x, y, s*0.025);

  float mw = s*0.25;
  float mh = s*0.14;
  float md = s*0.02;

  float sca = 0.9;

  rotate(random(TAU));

  beginShape();
  vertex(-mw, -mh, +md);
  vertex(+mw, -mh*sca, +md);
  vertex(+mw, +mh*sca, +md);
  vertex(-mw, +mh, +md);
  endShape();

  beginShape();
  vertex(-mw, -mh, -md);
  vertex(+mw, -mh*sca, -md);
  vertex(+mw, +mh*sca, -md);
  vertex(-mw, +mh, -md);
  endShape();

  beginShape();
  vertex(-mw, -mh, -md);
  vertex(+mw, -mh*sca, -md);
  vertex(+mw, -mh*sca, +md);
  vertex(-mw, -mh, +md);
  endShape();

  beginShape();
  vertex(+mw, -mh*sca, -md);
  vertex(+mw, +mh*sca, -md);
  vertex(+mw, +mh*sca, +md);
  vertex(+mw, -mh*sca, +md);
  endShape();

  beginShape();
  vertex(+mw, +mh*sca, -md);
  vertex(-mw, +mh, -md);
  vertex(-mw, +mh, +md);
  vertex(+mw, +mh*sca, +md);
  endShape();

  beginShape();
  vertex(-mw, -mh, -md);
  vertex(-mw, +mh, -md);
  vertex(-mw, +mh, +md);
  vertex(-mw, -mh, +md);
  endShape();

  line(0, 0, 0, 0, 0, s*0.2);
  translate(0, 0, s*0.05);
}
