void setup() {
  size(800, 800);
}

void draw() {
  float x = random(width);
  float y = random(height);
  float s = random(10, 100);
  fill(255);
  circle(x, y, s, int(random(3, 6)));
  float a = -PI/4;
  float d = s*0.22;
  fill(0);
  circle(x+cos(a)*d, y+sin(a)*d, s*random(0.32, 0.43), int(random(3, 5)));
  fill(255);
  circle(x+cos(a)*(d*1.22), y+sin(a)*(d*1.22), s*random(0.12, 0.2), int(random(3, 5)));
}

void circle(float x, float y, float d, int sec) {
  float r = d*0.5;
  float da = TWO_PI/sec;
  float kappa = 0.5522847498;
  float k = 4*kappa/sec;
  PVector points[] = new PVector[sec];

  for (int i = 0; i < sec; i++) {
    points[i] = new PVector(x+cos(da*i)*r+r*random(-0.1, 0.1), y+sin(da*i)*r+r*random(-0.1, 0.1));
  }

  stroke(0);
  beginShape();
  vertex(points[0].x, points[0].y);
  for (int i = 0; i < sec; i++) {
    bezierVertex(
    points[i].x+cos(da*i+PI/2)*r*k, points[i].y+sin(da*i+PI/2)*r*k, 
    points[(i+1)%sec].x+cos(da*(i+1)-PI/2)*r*k, points[(i+1)%sec].y+sin(da*(i+1)-PI/2)*r*k, 
    points[(i+1)%sec].x, points[(i+1)%sec].y
      );
  }
  endShape(CLOSE);
}

