import peasy.PeasyCam;

PeasyCam cam;

int seed = int(random(9999999));
float rotX = 0; 
float rotY = 0;
float rotZ = 0;
float newRotX = 0; 
float newRotY = 0;
float newRotZ = 0;

void setup() {
  size(800, 800, P3D);
  smooth(8);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);
  background(0);
}

void draw() {

  float time = millis()*0.0002;


  if (frameCount%120 == 0) {
    generate();
  }

  noiseSeed(seed);
  randomSeed(seed);

  background(0);
  //camera.update();

  blendMode(ADD);
  strokeWeight(1.4);
  stroke(240, 14, 2);
  noFill();
  rectMode(CENTER);

  int cc = 18;//int(random(20, 80));
  float ss = width*0.5/cc;

  float hh = width*0.2;
  float det1 = random(0.001);
  float det2 = random(0.001);

  rotX = lerp(rotX, newRotX, 0.02);
  rotY = lerp(rotY, newRotY, 0.02);
  rotZ = lerp(rotZ, newRotZ, 0.02);

  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  translate(0, 0, -hh*0.5);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      float xx = (i-cc*0.5)*ss;
      float yy = (j-cc*0.5)*ss;

      float ang1 = noise(xx*det1, yy*det1, time)*PI;
      float ang2 = noise(xx*det2, yy*det2, time)*PI;

      rect(xx, yy, ss*0.2, ss*0.2);
      line(xx, yy, 0, xx+cos(ang1)*sin(ang2)*hh, yy+cos(ang1)*cos(ang2)*hh, sin(ang1)*hh);
    }
  }
}

void keyPressed() {
  generate();
}

void generate() {
  background(0);
  seed = int(random(9999999));

  newRotX = random(PI); 
  newRotY = random(PI);
  newRotZ = random(TAU);
}
