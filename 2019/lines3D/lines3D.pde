import peasy.PeasyCam;

PeasyCam cam;

int seed = int(random(999999));

void setup() {
  size(1280, 720, P3D);
  smooth(4);

  cam = new PeasyCam(this, 400);

  generate();
}


void draw() {

  float time = millis()*0.001;

  background(240);

  randomSeed(seed);
  noiseSeed(seed);

  stroke(0);
  //beginShape(POINTS);
  float r = height*random(0.3, 0.45);
  for (int i = 0; i < 100; i++) {


    strokeWeight(random(1, 55)+pow(cos(time*random(8)), 3)*2);

    //ArrayList<PVector> points = new ArrayList<PVector>();

    float a1 = random(TAU)+time*random(-1, 1)*0.004;
    float a2 = random(TAU)+time*random(-1, 1)*0.004;

    float xx = cos(a1)*cos(a2)*r;
    float yy = cos(a1)*sin(a2)*r;
    float zz = sin(a1)*r;

    //point(xx, yy, zz);

    float det1 = random(0.0001);
    float des1 = random(1000);
    float det2 = random(0.0001);
    float des2 = random(1000);

    noFill();
    stroke(random(255), 0, random(255)*random(0.5, 1), 220);
    beginShape(LINES);
    for (int j = 0; j < 20; j++) {
      float aa1 = a1+noise(des1+xx*det1, des1+yy*det1, des1+zz*det1)*TAU*12;
      float aa2 = a2+noise(des2+xx*det2, des2+yy*det2, des2+zz*det2)*TAU*12;
      xx = cos(aa1)*cos(aa2)*r;
      yy = cos(aa1)*sin(aa2)*r;
      zz = sin(aa1)*r;
      vertex(xx, yy, zz);
    }
    endShape();
  }
  //endShape();
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(999999));
}
