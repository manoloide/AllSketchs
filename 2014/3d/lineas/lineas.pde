Mesh mesh;
float deltaTime;

void setup() {
  size(720, 480, P3D); 
  frameRate(60);
  smooth(32);
  mesh = new Mesh();
}

void draw() {
  deltaTime = (1./frameRate);
  translate(width/2, height/2, 0);
  rotateX(frameCount*0.0053);
  rotateY(frameCount*0.0023);
  rotateZ(frameCount*0.000077);
  //background(60);
  mesh.draw();

  colorMode(HSB, 256, 256, 256);
  for (int c = 0; c < 100; c++) {
    randomSeed(c*20);
    stroke(random(256), 200, 200);
    //strokeWeight(random(1, 4) );
    float defAng = 0.8; 
    int cant = 100;
    float des = 3;
    float ang1 = random(TWO_PI);
    float ang2 = random(TWO_PI);
    float x = 0;
    float y = 0; 
    float z = 0;
    for (int i = 0; i < cant; i++) {
      float ax = x;
      float ay = y;
      float az = z;

      ang1 += random(-defAng, defAng);
      ang2 += random(-defAng, defAng);
      x += cos(ang1)*sin(ang2)*des;
      y += sin(ang1)*sin(ang2)*des;
      z += cos(ang2)*des;
      for (int j = 0; j < 4; j++) {
        line(ax, ay, az, x, y, z);
      }
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    stroke(random(255), random(255)*random(1)*random(1));
    fill(random(255), random(255)*random(1)*random(0.1));
    mesh = new Mesh();
  }
}

void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1;
  saveFrame(nf(n, 3)+".png");
}
