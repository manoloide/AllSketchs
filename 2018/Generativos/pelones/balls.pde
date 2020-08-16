


void balls() {

  int cc = int(random(20, 120)*0.2);

  ArrayList<PVector> points = new ArrayList<PVector>();
  for (int i = 0; i < cc; i++) {
    points.add(new PVector(random(width), random(height), width*random(0.2)));
  }

  for (int i = 0; i < cc; i++) {
    PVector p = points.get(i);
    float xx = p.x; 
    float yy = p.y;
    float ss = p.z;

    arc2(xx, yy, ss, ss*1.2, 0, TAU, rcol(), 140, 0);
    arc2(xx, yy, ss, ss*3, 0, TAU, rcol(), 40, 0);
  }

  for (int i = 0; i < cc; i++) {
    PVector p = points.get(i);
    float xx = p.x; 
    float yy = p.y;
    float ss = p.z;

    int res = int(ss*PI);
    float j = 0;

    noStroke();
    //arc2(xx, yy, 0, ss*3, 0, TAU, rcol(), 40, 0);
    arc2(xx, yy, ss*0.4, ss*0.96, 0, TAU, color(255), 0, 40);
    noFill();
    stroke(0, 200);
    while (j < res) {
      float vel = random(1, 5);
      if (random(1) < 0.5) {
        float a1 = map(j, 0, res, 0, TAU);
        float a2 = map(j+vel, 0, res, 0, TAU); 
        arc(xx, yy, ss, ss, a1, a2);
      }
      j += vel;
    }
    noStroke();
    arc2(xx, yy, ss*0.2, ss*0.26, 0, TAU, color(255), 255, 255);
    fill(rcol(), 240);
    ellipse(xx, yy, ss*0.2, ss*0.2);


    noFill();
    for (int k = 0; k < 10; k++) {
      float val = map(k+1, 0, 10, 0, 1);
      float s = ss*(1+val*ss*0.02);
      stroke(255, 80*(1-val));
      ellipse(xx, yy, s, s);
    }
  }
}