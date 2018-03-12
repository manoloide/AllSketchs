int xx = 0;
int yy = 0;
int zz = 0;

void setup() {
  size(800, 600, P3D);
  sphereDetail(1);
  //ortho(0, width, 0, height);
}

void draw() {
  background(#383643);
  //translate(width/2, height/2, -100);
  rotateX(frameCount*0.002);
  rotateY(frameCount*0.00132);
  rotateZ(frameCount*0.000937);
  pushMatrix(); 
  int cant = 6;
  int sep = 50;
  noStroke();
  fill(250);
  if (frameCount%10 == 0) {
    if (random(1) < 0.5) {
      if (random(1) < 0.3333) {
        xx += (random(2) < 1)? -1 : 1;
      } else if (random(1) < 0.5) {
        yy += (random(2) < 1)? -1 : 1;
      } else {
        zz += (random(2) < 1)? -1 : 1;
      }
    }
  }
  for (int k = -cant/2; k <= cant/2; k++) {
    for (int j = -cant/2; j <= cant/2; j++) {
      for (int i = -cant/2; i <= cant/2; i++) {
        pushMatrix();
        float x = sep*i;
        float y = sep*j;
        float z = sep*k;
        translate(x, y, z);
        if (i == xx && j == yy && k == zz) {
          fill(250);
        } else {
          fill(250, 30);
        }
        sphere(3);
        //box(sep);
        popMatrix();
      }
    }
  }
  popMatrix();

  camera(70.0, 35.0, 120.0, 50.0, 50.0, 0.0, 
  0.0, 1.0, 0.0);
}

