void setup() {
  size(960, 960, P2D);
  pixelDensity(2);

  background(230);
  
  noStroke();
  fill(250);
  ellipse(width*0.25, height*0.25, width*0.4, width*0.4);
  ellipse(width*0.75, height*0.25, width*0.4, width*0.4);
  ellipse(width*0.75, height*0.75, width*0.4, width*0.4);
  ellipse(width*0.25, height*0.75, width*0.4, width*0.4);
  
  circle1(width*0.25, height*0.25, width*0.4, 400000);
  circle2(width*0.75, height*0.25, width*0.4, 400000);
  circle3(width*0.25, height*0.75, width*0.4, 400000);
  circle4(width*0.75, height*0.75, width*0.4, 400000);
  
  saveFrame("render.png");
}

void circle1(float x, float y, float s, int cc) {
  float r = s*0.5;
  for (int i = 0; i < cc; i++) {
    float angle = random(TAU);
    float radius = sqrt(random(1));
    stroke(0, random(80));
    point(x+cos(angle)*r*radius, y+sin(angle)*r*radius);
  }
}

void circle2(float x, float y, float s, int cc) {
  float r = s*0.5;
  for (int i = 0; i < cc; i++) {
    float angle = random(TAU);
    float radius = random(1);
    stroke(0, random(80));
    point(x+cos(angle)*r*radius, y+sin(angle)*r*radius);
  }
}


void circle3(float x, float y, float s, int cc) {
  float r = s*0.5;
  for (int i = 0; i < cc; i++) {
    float angle = random(TAU);
    float radius = 1-random(1)*random(1)*random(0.5, 1);
    stroke(0, random(80));
    point(x+cos(angle)*r*radius, y+sin(angle)*r*radius);
  }
}
void circle4(float x, float y, float s, int cc) {
  float r = s*0.5;
  for (int i = 0; i < cc; i++) {
    float angle = random(TAU);
    float radius = sqrt(random(1))*random(1);
    stroke(0, random(80));
    point(x+cos(angle)*r*radius, y+sin(angle)*r*radius);
  }
}
