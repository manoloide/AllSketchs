import peasy.PeasyCam;
import toxi.math.noise.SimplexNoise;

PeasyCam cam;

int seed = int(random(999999));

void setup() {
  //size(540, 960, P3D);
  size(1920, 1080, P3D);
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
  for (int k = 0; k < 5; k++) {
    //beginShape(POINTS);
    float r = height*random(0.3, 0.45)*map(k, 0, 5, 1, 0);
    for (int i = 0; i < 60; i++) {


      strokeWeight(random(1, 55)+pow(cos(time*random(8)), 3)*2);
      strokeWeight(1);

      ArrayList<PVector> points = new ArrayList<PVector>();

      float a1 = random(TAU)+time*random(-1, 1)*0.004+time*random(-1, 1)*random(0.5)*random(1);
      float a2 = random(TAU)+time*random(-1, 1)*0.004+time*random(-1, 1)*random(0.5)*random(1);

      float xx = cos(a1)*cos(a2)*r;
      float yy = cos(a1)*sin(a2)*r;
      float zz = sin(a1)*r;

      //point(xx, yy, zz);

      float det1 = random(0.01);
      float des1 = random(1000);
      float det2 = random(0.02);
      float des2 = random(1000);

      noFill();
      stroke(random(255), 0, random(255)*random(0.5, 1), 220);
      //beginShape(LINES);
      for (int j = 0; j < 20; j++) {
        a1 += ((float)SimplexNoise.noise(des1+xx*det1, des1+yy*det1, des1+zz*det1))*0.05;
        a2 += ((float)SimplexNoise.noise(des2+xx*det2, des2+yy*det2, des2+zz*det2))*0.05;
        xx = cos(a1)*cos(a2)*r;
        yy = cos(a1)*sin(a2)*r;
        zz = sin(a1)*r;
        vertex(xx, yy, zz);

        points.add(new PVector(xx, yy, zz));
      }
      //endShape();

      noStroke();
      fill(random(255), 0, random(255)*random(0.5, 1), 220);
      drawLine(points, random(8)*random(1));
    }
  }
  //endShape();
}

void drawLine(ArrayList<PVector> points, float str) {

  ArrayList<PVector> np = new ArrayList<PVector>();

  float rr = str*0.5;
  for (int i = 1; i < points.size(); i++) {
    PVector ant = points.get(i-1);
    PVector act = points.get(i-0);
    float p1x = screenX(ant.x, ant.y, ant.z);
    float p1y = screenY(ant.x, ant.y, ant.z);
    //float p1z = screenZ(ant.x, ant.y, ant.z);
    float p2x = screenX(act.x, act.y, act.z);
    float p2y = screenY(act.x, act.y, act.z);
    //float p2z = screenZ(act.x, act.y, act.z);

    //if (p2z > 0) {
    float a = atan2(p2y-p1y, p2x-p1x)+HALF_PI;
    np.add(new PVector(p2x+cos(a)*rr, p2y+sin(a)*rr));
    np.add(new PVector(p2x+cos(a+PI)*rr, p2y+sin(a+PI)*rr));
    //}
  }

  cam.beginHUD();
  beginShape(QUAD_STRIP);
  for (int i = 0; i < np.size(); i++) {
    PVector p = np.get(i);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
  cam.endHUD();
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(999999));
}
