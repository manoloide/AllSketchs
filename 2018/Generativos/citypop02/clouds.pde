void cloud(float hor, float det) {
  int clouds[] = {#FFFFFF, #EEEEEE, #DDDDDD};//, #29714B, #92CFAF};
  ArrayList<PVector> points = new ArrayList<PVector>();
  float w = width*random(0.2, 0.5)*2;
  float x = random(width);
  float y = random(hor)*random(0.5, 0.8);
  float ramp = random(0.4);
  for (int i = 0; i < 6000; i++) {
    float dx = random(w)-w*0.5;
    float ady = 1-sin(map(dx, 0, w, 0, PI));
    float dy = -height*random(-ramp*0.5+ramp*noise(x*det*100)*ady);
    float amp = pow(cos(map(dx, 0, w, HALF_PI, PI*1.5)), 2);
    float s = width*random(0.006, 0.008)*4*amp;
    boolean add = true;
    for (int j = 0; j < points.size(); j++) {
      PVector o = points.get(j);
      if (dist(x+dx, y-dy, o.x, o.y) < 2) {
        add = false;
        break;
      }
    }
    if (add) points.add(new PVector(x+dx, y-dy, s));
  }

  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    fill(clouds[int(random(clouds.length))], random(40, 180)*0.012);
    ellipse(p.x, p.y, p.z, p.z);
  }
}
