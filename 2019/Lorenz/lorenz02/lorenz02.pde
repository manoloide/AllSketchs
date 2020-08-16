float a = 10;
float b = 28;
float c = 8./3;

int frames = 80; 

void setup() {
  size(500, 500, P3D);
  smooth(4);
}

void draw() {

  background(255);

  translate(width/2, height/2, -200);
  
  float tt = map(frameCount, 0, frames, 0, 1);
  
  rotateY(TAU*tt);

  float x = 10; 
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
  
  
  saveFrame("f####.png");
  if(frameCount > frames) exit();
}
