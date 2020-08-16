import peasy.PeasyCam;

ArrayList<Line> lines;
PeasyCam cam;

int seed = int(random(99999999));

void settings() {
  size(960*2/3, 540*2/3, P3D);
  pixelDensity(2);
  smooth(8);
}

void setup(){
  cam = new PeasyCam(this, 400);
  generate();
}

void draw() {

  background(0);
  randomSeed(seed);
  noiseSeed(seed);
  
  hint(DISABLE_DEPTH_TEST);

  stroke(255);
  noFill();
  for (int i = 0; i < lines.size(); i++) {
    Line l = lines.get(i);
    l.update();
    l.show();
    if (l.remove) lines.remove(i--);
  }
}

void keyPressed() {
  seed = int(random(99999999));
  generate();
}

void generate() {
  lines = new ArrayList<Line>();
  for (int i = 0; i < 100; i++) {
    lines.add(new Line());
  }
}

class Line {
  ArrayList<PVector> points;
  boolean remove;
  float x, y, z;
  float a1, a2;
  float det, des1, des2;
  int lineType;
  Line() {
    det = random(0.01);
    des1 = random(1000);
    des2 = random(1000);
    points = new ArrayList<PVector>();
    lineType = int(random(3));
  }
  void update() {
    float vel = 3;
    float a1 = noise(des1+x*det, des1+y*det, des1+z*det)*TAU*2;
    float a2 = noise(des2+x*det, des2+y*det, des2+z*det)*TAU*2;
    x += cos(a1)*cos(a2)*vel;
    y += cos(a1)*sin(a2)*vel;
    z += sin(a1)*vel;
    
    lineType = int(random(2));

    if (points.size() < 200) points.add(new PVector(x, y, z));
  }
  void show() {
    fill(rcol(), 180);
    if(lineType == 0) beginShape();
    if(lineType == 1) beginShape(POINTS);
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      vertex(p.x, p.y, p.z);
    }
    endShape();
  }
}


int colors[] = {#FF3D20, #FC9D43, #3998C2, #3E56A8, #090D0E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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
