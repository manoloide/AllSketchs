float time = 0;

void setup() {
  size(640, 640, P3D);
  smooth(8);
}


void draw() {
  background(10);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*80.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);

  time += 1/60.; 

  if (time > 6) {
    time = 0;
    noiseSeed(int(random(999999)));
  }
  int cc = 20;
  float d = 0.01;
  float w = 500;
  float des = w/cc;
  translate(width/2, height/2, -400);
  rotateY(frameCount*0.01);
  stroke(255, 5); 
  translate(0, 120, 0);
  pushMatrix();
  rotateX(PI/2);
  grid(0, 0, 500, 500, 40, 40);
  grid(0, 0, 500, 500, 10, 10);
  popMatrix();
  stroke(255, 100);
  translate(-w/2., 0, 0);

  for (int i = 0; i < cc; i++) {
    float x = i*des+des/2;
    float y = 0;
    float h = 20+i*10+noise(x*d, y*d)*120;
    h *= constrain(map((time*3-i*0.2), 0, 2, 0, 1), 0, 1);
    line(x, y, x, y-h);
  }
}

void keyPressed() {
  time = 0;
}

void grid(float x, float y, float w, float h, int cw, int ch) {
  float dx = w/cw;
  float dy = h/ch;
  float des;
  for (int j = 0; j <= ch; j++) {
    des = -h/2+dy*j;
    line(x-w/2., des, x+w/2., des);
  }
  for (int i = 0; i <= cw; i++) {
    des = -w/2+dx*i;
    line(des, y-h/2., des, y+h/2.);
  }
}

