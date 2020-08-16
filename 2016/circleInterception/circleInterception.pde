ArrayList<Circle> circles;

void setup() {
  size(960, 960);
  generate();
}

void draw() {
  background(240);
  for (int i = 0; i < circles.size(); i++) {
    Circle c = circles.get(i);
    c.update();
  }

  for (int i = 0; i < circles.size(); i++) {
    Circle act = circles.get(i);
    for (int j = i+1; j < circles.size(); j++) {
      Circle aux = circles.get(j);
      float[] points = pointsCircle(new PVector(act.x, act.y, act.s), new PVector(aux.x, aux.y, aux.s)); 
      if (points != null) {
        float ss = (aux.s+act.s)*0.05;
        strokeWeight(max(1, ss*0.02));
        ellipse(points[0], points[1], ss, ss);
        ellipse(points[2], points[3], ss, ss);
      }
    }
  }
}

void keyPressed() {
  generate();
}

void generate() {
  circles = new ArrayList<Circle>(); 
  for (int i = 0; i < 20; i++) {
    circles.add(new Circle(random(width), random(height), random(20, 500)));
  }
}

class Circle {
  float x, y, s;
  float ang, vel;

  Circle(float x, float y, float s) {
    this.x = x;
    this.y = y;
    this.s = s;
    ang = random(TWO_PI);
    vel = random(1);
  }

  void update() {
    ang += random(-0.01, 0.01);
    x += cos(ang)*vel;
    y += sin(ang)*vel;

    if (x < -s) x += width + s*2;
    if (x > width+s) x -= width + s*2;
    if (y < -s) x += height + s*2;
    if (y > height+s) x -= height + s*2;
    show();
  }

  void show() {
    noFill();
    stroke(220);
    strokeWeight(s*0.02);
    ellipse(x, y, s, s);
    strokeWeight(s*0.01);
    line(x-s*0.02, y, x+s*0.02, y);
    line(x, y-s*0.02, x, y+s*0.02);
  }
}


public float[] pointsCircle(PVector c1, PVector c2) {
  float x1 = c1.x;
  float y1 = c1.y;
  float x2 = c2.x;
  float y2 = c2.y;
  float r1 = c1.z*0.5;
  float r2 = c2.z*0.5;
  float a = x2 - x1;
  float b = y2 - y1;
  float ds = a*a + b*b;
  float d = sqrt(ds);

  if (r1 + r2 <= d)
    return null;
  if (d <= abs( r1 - r2 ))
    return null;
  float t = sqrt( (d + r1 + r2) * (d + r1 - r2) * (d - r1 + r2) * (-d + r1 + r2) );
  float sx1 = 0.5 * (a + (a*(r1*r1 - r2*r2) + b*t)/ds);
  float sx2 = 0.5 * (a + (a*(r1*r1 - r2*r2) - b*t)/ds);
  float sy1 = 0.5 * (b + (b*(r1*r1 - r2*r2) - a*t)/ds);
  float sy2 = 0.5 * (b + (b*(r1*r1 - r2*r2) + a*t)/ds);

  sx1 += x1;
  sy1 += y1;
  sx2 += x1;
  sy2 += y1;

  float[] r = new float[4];
  r[0] = sx1;
  r[1] = sy1;
  r[2] = sx2;
  r[3] = sy2;

  return r;
}