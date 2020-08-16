
void connects(ArrayList<PVector> points) {
  ArrayList<PVector> reached = new ArrayList<PVector>();
  ArrayList<PVector> unreached = new ArrayList<PVector>();

  for (int i = 0; i < points.size(); i++) {
    unreached.add(points.get(i));
  }

  if (unreached.size() > 0) {
    int ind = int(random(unreached.size()));
    reached.add(unreached.get(ind));
    unreached.remove(ind);
  }


  while (unreached.size() > 0) {
    float record = 10000;
    int rIndex = 0;
    int uIndex = 0;
    for (int i = 0; i < reached.size(); i++) {
      PVector v1 = reached.get(i);
      for (int j = 0; j < unreached.size(); j++) {
        PVector v2 = unreached.get(j);
        float d = v1.dist(v2);
        if (d < record) {
          record = d;
          rIndex = i;
          uIndex = j;
        }
      }
    }

    stroke(230, 240, 250);
    lines(reached.get(rIndex).x, reached.get(rIndex).y, unreached.get(uIndex).x, unreached.get(uIndex).y);

    reached.add(unreached.get(uIndex));
    unreached.remove(uIndex);
  }
}

void lines(float x1, float y1, float x2, float y2) {
  float w = abs(x2-x1);
  float h = abs(y2-y1);
  float dis = dist(x1, y1, x2, y2);
  float ang = atan2(y2-y1, x2-x1);
  int seg = int(dis*6);
  fill(0, 10);
  //beginShape();
  for (int i = 0; i <= seg; i++) {
    blendMode(NORMAL);
    if (random(1) < 0.2) blendMode(ADD);
    float v = pow(i*1./seg, 2);
    float xx = lerp(x1, x2, v);
    float yy = lerp(y1, y2, v);
    float ar = HALF_PI*(0.1+pow(v, 3))*random(1)*random(1);

    strokeWeight(dis*pow(v, 0.8)*0.006*random(0.6, 1));

    float noi = noise(xx*detCol*2, yy*detCol*2)*2*colors.length+desCol+random(random(1), 1)*random(random(1), 1);
    //int c1 = lerpColor(getColor(noi), color(255), random(0.1)*random(1));
    stroke(getColor(noi), random(random(255), 255));
    float r = dis*0.2*pow(v, 4);
    line(xx, yy, xx+cos(ang-ar)*r, yy+sin(ang-ar)*r);
    r = dis*0.4*(v);
    stroke(getColor(noi), random(random(255), 255)*0.6);
    line(xx, yy, xx+cos(ang+ar)*r, yy+sin(ang+ar)*r);
  }
  blendMode(NORMAL);
  //endShape();
}
