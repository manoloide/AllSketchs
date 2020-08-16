void campo() {

  float detArb = random(0.01);
  float desArb = random(1000);

  ArrayList<PVector> pts = new ArrayList<PVector>();

  int cc = 1000;
  for (int i = 0; i < cc; i++) {
    float x = random(width); 
    float v = pow(i*1./cc, 1.8);
    float y = height*(0.5+v*0.5);

    noStroke();
    if (random(1) < 0.004) {
      molino(x, y, v*0.5);
    } else if (random(1) < 0.004) {
      pts.add(new PVector(x, y, v));
    } else {
      float n = noise(desArb+x*detArb*v, desArb+y*detArb);
      n = n*8-4;
      n = constrain(n, 0, 1);
      float s = n*12;

      stroke(0);
      line(x, y-s*0.25, x, y+s*0.5);
      noStroke();
      //fill(#22261c);
      //ellipse(x+1, y-s*0.5+1, s, s*0.8);
      fill(lerpColor(#404835, #3D4810, random(1)));
      ellipse(x, y-s*0.25, s*1.0, s*0.8);
    }
  }

  stroke(0);
  for (int j = 0; j < pts.size(); j++) {
    PVector p = pts.get(j);
    line(p.x, p.y, p.x, p.y-p.z*50);
    p.y -= p.z*50;
    p.z = 0;
  }

  ArrayList<Triangle> tris = Triangulate.triangulate(pts);
  noFill();
  stroke(0);
  beginShape(TRIANGLES);
  for (int i = 0; i < tris.size(); i++) {
    Triangle t = tris.get(i);
    vertex(t.p1.x, t.p1.y);
    vertex(t.p2.x, t.p2.y);
    vertex(t.p3.x, t.p3.y);
  }
  endShape();
}

void molino(float x, float y, float s) {
  float w = 5*s;
  float h = w*40;

  beginShape();
  fill(#929391);
  vertex(x-w*1.2, y+h*0.0);
  vertex(x-w*0.3, y-h*1.0);
  fill(#bbbdb7);
  vertex(x+w*0.3, y-h*1.0);
  vertex(x+w*1.2, y+h*0.0);
  endShape();

  float rr = w*14;
  float da = TAU/3;
  float ang = random(TAU);

  //stroke(#929391);
  beginShape(TRIANGLES);
  for (int i = 0; i < 3; i++) {
    float a = da*i+ang;
    fill(#bbbdb7);
    vertex(x, y-h);
    fill(#929391);
    vertex(x+cos(a)*rr, y-h+sin(a)*rr);
    vertex(x+cos(a+0.6)*rr*0.18, y-h+sin(a+0.6)*rr*0.18);
  }
  endShape();
}

int rcol(int[] cols) {
  return cols[int(random(cols.length))];
}
int getColor(int[] cols) {
  return getColor(random(cols.length));
}
int getColor(int[] cols, float v) {
  v = abs(v); 
  v = v%(cols.length); 
  int c1 = cols[int(v%cols.length)]; 
  int c2 = cols[int((v+1)%cols.length)]; 
  return lerpColor(c1, c2, pow(v%1, 1.8));
}
