void setup() {
  size(640, 640, P2D);
  pixelDensity(2);
}

void draw() {
  background(0);
  stroke(255);

  simpleLines2();
}

void keyPressed() {
  saveFrame("####.png");
}

float powVal(float val) {
  if (val > 1) return val; 
  else return 1/val;
}

void simpleLines() {
  int cc = 20; 
  float vel1 = 0.02;
  float vel2 = 0.023;
  float amp = 0.9;
  for (int i = 0; i <= cc; i++) {
    float v1 = pow(i*1./cc, powVal(1+cos(frameCount*vel1)*amp))*width;
    float v2 = pow(i*1./cc, powVal(1+cos(frameCount*vel2)*amp))*width; 

    line(v1, 0, v2, height);
  }
}

PVector pointTrans(float x, float y, float p1, float p2, float p3, float p4) {
  x /= width; 
  y /= height;

  float xx = lerp(pow(x, p1), pow(x, p2), y)*width;
  float yy = lerp(pow(y, p3), pow(y, p4), x)*height;

  return new PVector(xx, yy);
}

void simpleLines2() {
  int cc = 40; 
  float vel1 = 0.02;
  float vel2 = 0.023;
  float vel3 = 0.019;
  float vel4 = 0.0223;
  float amp = 0.4;
  float p1 = 1+cos(frameCount*vel1)*amp;
  float p2 = 1+cos(frameCount*vel2)*amp;
  float p3 = 1+cos(frameCount*vel3)*amp;
  float p4 = 1+cos(frameCount*vel4)*amp;
  for (int i = 0; i <= cc; i++) {
    float v1 = pow(i*1./cc, p1)*width;
    float v2 = pow(i*1./cc, p2)*width; 
    float v3 = pow(i*1./cc, p3)*height;
    float v4 = pow(i*1./cc, p4)*height; 

    //line(v1, 0, v2, height);
    //line(0, v3, width, v4);
  }

  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float xx = map(i, 0, cc, 0, width);
      float yy = map(j, 0, cc, 0, height);
      PVector p = pointTrans(xx, yy, p1, p2, p3, p4);
      ellipse(p.x, p.y, 3, 3);
    }
  }
}