void tren(float ss) {
  fill(255, 255, 0);
  for (int i = 0; i < builds.size(); i++) {
    PVector b = builds.get(i);
    pushMatrix();
    translate(b.x, b.y, b.z+ss*4);
    sphere(6);
    popMatrix();
  }
}

class Spline {
  ArrayList<PVector> points;
  float dists[];
  float length;
  Spline(ArrayList<PVector> points) {
    this.points = points;
    calculate();
  }

  void calculate() {
    dists = new float[points.size()+1];
    length = 0; 

    int res = 10;
    for (int i = 0; i <= points.size(); i++) {
      float ndis = 0;
      PVector ant = getPointLin(i);
      for (int j = 1; j <= res; j++) {
        PVector act = getPointLin(i+j*1./res);
        ndis += ant.dist(act);
        ant = act;
      }
      dists[i] = length;
      if (points.size() != i) length += ndis;
    }
  }

  void show() {
    PVector p1, p2, p3, p4;
    p1 = points.get(points.size()-1);
    p2 = points.get(0);
    p3 = points.get(1);
    p4 = points.get(2);
    curveTightness(0);
    curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
    for (int i = 0; i < points.size()-1; i++) {
      p1 = points.get(i);
      p2 = points.get(i+1);
      p3 = points.get((i+2)%points.size());
      p4 = points.get((i+3)%points.size());
      curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
    }
    curve(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z, p3.x, p3.y, p3.z, p4.x, p4.y, p4.z);
  }

  PVector getPointLin(float v) {
    v = v%points.size();
    int ind = int(v);
    float m = v%1.;
    return calculatePoint(ind, m);
  }

  PVector getPoint(float v) {
    v = (v%1)*length;
    int ind = 0;
    float antLen = dists[ind];
    float actLen = dists[ind+1];
    while (actLen < v && ind <= points.size()) { 
      ind++;
      antLen = actLen;
      actLen = dists[(ind+1)];
    }
    float m = map(v, antLen, actLen, 0, 1);
    return calculatePoint(ind, m);
  }

  PVector calculatePoint(int ind, float m) {
    int ps = points.size();
    PVector p1 = points.get((ind-1+ps)%ps);
    PVector p2 = points.get((ind+0+ps)%ps);
    PVector p3 = points.get((ind+1+ps)%ps);
    PVector p4 = points.get((ind+2+ps)%ps);
    float xx = curvePoint(p1.x, p2.x, p3.x, p4.x, m);
    float yy = curvePoint(p1.y, p2.y, p3.y, p4.y, m);
    float zz = curvePoint(p1.z, p2.z, p3.z, p4.z, m);
    return new PVector(xx, yy, zz);
  }

  PVector getDir(float v) {
    PVector act = getPoint(v);
    PVector p1 = act.copy().sub(getPoint(v-0.01));
    PVector p2 = getPoint(v+0.01).sub(act);
    PVector aux = p1.add(p2).mult(0.5);
    return aux.normalize();
  }
}  
