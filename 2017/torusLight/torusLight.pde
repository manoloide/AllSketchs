import peasy.*;

PeasyCam cam;

void setup() {
  size(720, 720, P3D);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  pixelDensity(2);
  generate();
}


void draw() {
  background(240);
  //translate(width/2, height/2, -300);
  stroke(20);
  strokeWeight(3);
  torus(300, 300, 600, 1200);
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void generate() {
}

void torus(int i1, int i2, float s1, float s2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  ArrayList<PVector> points = new ArrayList<PVector>(); 
  float da = TWO_PI/i1;
  float det = 0.05;
  for (int j = 0; j <= i2; j++) {
    for (int i = 0; i < i1; i++) {
      /*
      float ang = da*i;
       float h = map(j, 0, i2, -s2, s2); 
       float rr = r1+noise(i*det, j*det, frameCount*0.01)*500-250; 
       PVector p = new PVector(cos(ang)*rr, h, sin(ang)*rr);
       points.add(p);
       */
      float theta = map(j, 0, i2, 0, PI);
      float phi = map(i, 0, i1, 0, TWO_PI);
      float rr = r1+noise(i*det, j*det, frameCount*0.01)*40-20; 

      float x = cos(theta)*sin(phi)*rr;
      float y = sin(theta)*sin(phi)*rr;
      float z = cos(phi)*rr;
      points.add(new PVector(x, y, z));
    }
  }

  stroke(0, 120);
  strokeWeight(1);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    point(p.x, p.y, p.z);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}