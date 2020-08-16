float a = 10;
float b = 28;
float c = 8./3;

void setup() {
  size(600, 600, P3D);
  smooth(4);
}

void draw() {

  background(255);

  translate(width/2, height/2);

  float x = 1; 
  float y = 0;
  float z = 0;

  float dt = 0.004;
  float scale = 6;

  noFill();
  beginShape();
  for (int i = 0; i < 10000; i++) {
    vertex(x*scale, y*scale, z*scale);

    x += (a * (y - x)) * dt;
    y += ((x * (b - z)) - y)*dt;
    z += (x*y-c*z)*dt;
  }
  endShape();
  
  saveFrame("test01.png");
}
