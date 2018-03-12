int seed = 0;

void setup() {
  size(960, 960, P3D);
  smooth(4);
  generate();
}

void draw() {
  translate(width/2, height/2, -200);
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    //generate();
    seed = int(random(99999999));
  }
}

void generate() {
  background(255);
  randomSeed(seed);

  int cc = 8;
  int ss = 60;
  int tt = cc*ss;
  stroke(0, 20);
  strokeWeight(0.5);
  rotateX(frameCount*0.03);
  rotateY(frameCount*0.0017);
  rotateZ(frameCount*0.007);
  translate(-tt/2., -tt/2., -tt/2.);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      line(0, i*ss, j*ss, tt, i*ss, j*ss);
      line(i*ss, 0, j*ss, i*ss, tt, j*ss);
      line(i*ss, j*ss, 0, i*ss, j*ss, tt);
    }
  }

  strokeWeight(1);
  stroke(0, 160);
  noFill();
  for (int i = 0; i < 100; i++) {
    pushMatrix();
    float x = int(random(1, cc))*ss;
    float y = int(random(1, cc))*ss;
    float z = int(random(1, cc))*ss;
    translate(x, y, z);
    rotateX(int(random(4))*PI/2);
    rotateY(int(random(4))*PI/2);
    rotateZ(int(random(4))*PI/2);
    arc(0, 0, ss*2, ss*2, 0, PI/2);
    popMatrix();
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

