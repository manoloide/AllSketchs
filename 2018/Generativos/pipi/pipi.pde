int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

int back;

void generate() {

  randomSeed(seed);

  back = rcol();
  background(back);
  float fov = PI/random(2., 3.6);
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), cameraZ/100.0, cameraZ*100.0);
  translate(width/2, height/2);
  rotateX(random(0, PI*0.5));

  ArrayList<Triangle> ts = new ArrayList<Triangle>();
  float ang = random(TAU);
  float dis = width*random(2, 5);//random(1, 3);
  float da = TAU/3.0;
  ts.add(new Triangle(cos(ang)*dis, sin(ang)*dis, cos(ang+da)*dis, sin(ang+da)*dis, cos(ang-da)*dis, sin(ang-da)*dis));
  int sub = int(random(3000));
  noStroke();
  for (int i = 0; i < sub; i++) {
    int ind = int(random(ts.size()));
    Triangle t = ts.get(ind);
    if (random(1) < 0.9) {
      ts.add(new Triangle(t.p1.x, t.p1.y, t.p1.z, (t.p1.x+t.p2.x)*0.5, (t.p1.y+t.p2.y)*0.5, (t.p1.z+t.p2.z)*0.5, (t.p1.x+t.p3.x)*0.5, (t.p1.y+t.p3.y)*0.5, (t.p1.z+t.p3.z)*0.5));
      ts.add(new Triangle(t.p2.x, t.p2.y, t.p2.z, (t.p2.x+t.p3.x)*0.5, (t.p2.y+t.p3.y)*0.5, (t.p2.z+t.p3.z)*0.5, (t.p2.x+t.p1.x)*0.5, (t.p2.y+t.p1.y)*0.5, (t.p2.z+t.p1.z)*0.5));
      ts.add(new Triangle(t.p3.x, t.p3.y, t.p3.z, (t.p3.x+t.p1.x)*0.5, (t.p3.y+t.p1.y)*0.5, (t.p3.z+t.p1.z)*0.5, (t.p3.x+t.p2.x)*0.5, (t.p3.y+t.p2.y)*0.5, (t.p3.z+t.p2.z)*0.5));
      ts.add(new Triangle((t.p1.x+t.p2.x)*0.5, (t.p1.y+t.p2.y)*0.5, (t.p1.z+t.p2.z)*0.5, (t.p3.x+t.p2.x)*0.5, (t.p3.y+t.p2.y)*0.5, (t.p3.z+t.p2.z)*0.5, (t.p3.x+t.p1.x)*0.5, (t.p3.y+t.p1.y)*0.5, (t.p3.z+t.p1.z)*0.5));
    } else {
      float d = t.p1.dist(t.p2);
      d = (sqrt(6)/3)*d;
      PVector c = ((t.p1.copy().add(t.p2)).add(t.p3)).div(3);
      PVector n = ((t.p2.copy().sub(t.p1)).cross((t.p3.copy().sub(t.p1)))).normalize().mult(d);
      PVector np = c.copy().add(n);
      ts.add(new Triangle(t.p1.x, t.p1.y, t.p1.z, t.p2.x, t.p2.y, t.p2.z, np.x, np.y, np.z));
      ts.add(new Triangle(t.p2.x, t.p2.y, t.p2.z, t.p3.x, t.p3.y, t.p3.z, np.x, np.y, np.z));
      ts.add(new Triangle(t.p3.x, t.p3.y, t.p3.z, t.p1.x, t.p1.y, t.p1.z, np.x, np.y, np.z));
    }
    ts.remove(ind);
  }

  for (int i = 0; i < ts.size(); i++) {
    Triangle t = ts.get(i);
    fill(rcol());
    noFill();
    stroke(0);
    beginShape();
    vertex(t.p1.x, t.p1.y, t.p1.z);
    vertex(t.p2.x, t.p2.y, t.p2.z);
    vertex(t.p3.x, t.p3.y, t.p3.z);
    endShape();
    t.show();
  }
}

class Triangle {
  PVector p1, p2, p3;
  Triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    p1 = new PVector(x1, y1, 0); 
    p2 = new PVector(x2, y2, 0); 
    p3 = new PVector(x3, y3, 0);
  }
  Triangle(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3) {
    p1 = new PVector(x1, y1, z1); 
    p2 = new PVector(x2, y2, z2); 
    p3 = new PVector(x3, y3, z3);
  }
  void show() {
    beginShape();
    int col = rcol();
    fill(lerpColor(col, rcol(), random(0.1)));
    vertex(p1.x, p1.y, p1.z);
    fill(lerpColor(col, rcol(), random(0.1)));
    vertex(p2.x, p2.y, p2.z);
    fill(lerpColor(col, rcol(), random(0.1)));
    vertex(p3.x, p3.y, p3.z);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FACC02, #FB0603, #0365BC, #0D6305, #000000, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}