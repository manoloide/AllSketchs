

void back() {
  ArrayList<PVector> points = new ArrayList<PVector>();


  background(10);//trgetColor());
  //background(250);
  noStroke();
  float det = random(0.02);
  for (int i = 0; i < 10000; i++) {
    float x = random(width);
    float y = random(height);
    float s = 3+pow(noise(x*det, y*det), 1.5)*45;
    s *= 0.3;
    boolean add = true;
    for (int k = 0; k < points.size(); k++) {
      PVector other = points.get(k);
      float dd = (s+other.z)*0.5;
      if (abs(other.x-x) > dd || abs(other.y-y) > dd) continue;
      if (dist(x, y, other.x, other.y) < dd) {

        add = false;
        break;
      }
    }
    strokeWeight(2);
    if (add) {
      points.add(new PVector(x, y, s));
      /*
      noStroke();
       fill(0);
       if (random(1) < 0.2) continue;
       if (random(1) < 0.1) fill(rcol());
       ellipse(x, y, 4, 4);
       */
    }
  }



  detDes = random(0.01);
  desDes = random(1000);

  //strokeWeight(3);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    if (random(1) < 0.1) continue;
    if (random(1) < 0.003) {
      float s = p.z;
      //if (random(1) < 0.9) s *= 0.1;
      //flower(p.x, p.y, s, detCol, desCol);
    }
    /*
    float noi = noise(p.x*detCol, p.y*detCol)*colors.length*2.5+desCol+random(random(1), 1)*random(random(1), 1);
     int c1 = lerpColor(getColor(noi), color(255), random(0.1)*random(1));
     if (random(1) < 0.2)
     c1 = lerpColor(c1, color(255), random(1));
     fill(0, 200);
     if (random(1) < 0.1) continue;
     if (random(1) < 0.9) fill(c1, 230);
     ellipse(p.x, p.y, p.z*1.2, p.z*1.2);
     */
  }
}
