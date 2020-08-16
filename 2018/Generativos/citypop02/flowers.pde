
void flowers(float hor) {

  float det = random(0.003, 0.008);
  noiseDetail(2);
  int grass[] = {#262A29, #184739};//, #29714B, #92CFAF};
  float hh = 0.2;
  for (int i = 0; i < 100000; i++) {
    float x = random(width);
    float dy = random(hh*0.5-hh*noise(x*det));
    if (dy < 0) continue;
    float y = hor-height*dy;
    float s = width*random(0.01, 0.02)*0.3;
    fill(0, random(80), random(80));
    fill(grass[int(random(grass.length))], 20);
    ellipse(x, y, s, s);
  }
  int flowers[] = {#E4D548, #175632, #B23A78};//, #29714B, #92CFAF};
  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < 1000; i++) {
    float x = random(width);
    float dy = random(hh*0.5-hh*noise(x*det));
    if (dy < 0) continue;
    float y = hor-height*dy;
    float s = width*random(0.006, 0.008)*0.3;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x, y, o.x, o.y) < 2) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x, y, s));
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(0, random(80), random(80));
    fill(flowers[int(random(flowers.length))]);
    ellipse(p.x, p.y, p.z, p.z);
  }
}

void ballFlowers(float x, float y, float s){
   
  fill(0);
  ellipse(x, y, s, s*0.2);
}
