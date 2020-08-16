int seed;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  generate();
}

void draw() {
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999999));
  }
  //generate();
}

void generate() {
  randomSeed(seed);
  noiseSeed(seed);
  background(240);
  float fov = random(0.1, 1)*PI/2.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
  cameraZ/10.0, cameraZ*10.0);
  translate(width/2, height/2, -300);
  for (int c = 0; c < 10; c++) {
    pushMatrix();
    rotateX(random(-0.2, 0.2));
    rotateY(random(-0.2, 0.2));
    rotateZ(random(-0.2, 0.2));
    int cc = int(random(20, 120));
    int ss = int(random(3, 20));
    int tt = cc*ss;
    float det = random(0.005, 0.1);
    translate(-tt/2, -tt/2, 0);
    stroke(0, 80);
    float time = frameCount*random(0.001, 0.06)+random(1000);

    /*
    color c1 = color(random(255), random(256), random(256));
     color c2 = color(random(255), random(256), random(256));
     color c3 = color(random(255), random(256), random(256));
     color c4 = color(random(255), random(256), random(256));
     */

    stroke(random(100), 120);
    for (int j = 0; j < cc; j++) {
      //color mc1 = lerpColor(c1, c2, map(j, 0, cc-1, 0, 1));
      //color mc2 = lerpColor(c2, c3, map(j, 0, cc-1, 0, 1));
      for (int i = 0; i < cc; i++) {
        //stroke(lerpColor(mc1, mc2, map(i, 0, cc-1, 0, 1)), 160);
        line(i*ss, j*ss, -tt/2, i*ss, j*ss, -tt/2+noise(i*det+time, j*det+time)*tt);
      }
    }
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

