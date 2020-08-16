import peasy.PeasyCam;

int seed = int(random(999999));

PeasyCam cam;
PVector pos, npos;

void setup() {
  size(960, 540, P3D);
  smooth(4);
  pixelDensity(2);
  cam = new PeasyCam(this, 400);

  pos = new PVector();
  npos = new PVector();
}

float size;
void draw() {
  int cc = 10; 
  size = width*1./cc;

  background(0);

  pushMatrix();
  stroke(255);
  noFill();
  box(size*0.2);
  line(-size*0.5, 0, 0, size*0.5, 0, 0);
  line(0, -size*0.5, 0, 0, size*0.5, 0);
  line(0, 0, -size*0.5, 0, 0, size*0.5);
  box(size);


  pos.lerp(npos, 0.1);
  translate(-size*cc*0.5+pos.x, -size*cc*0.5+pos.y, -size*cc*0.5+pos.z);
  for (int k = 0; k < cc; k++) {
    for (int j = 0; j < cc; j++) {
      for (int i = 0; i < cc; i++) {
        pushMatrix();
        translate(size*i, size*j, size*k);
        noStroke();
        fill(255);
        box(size*0.01);
        stroke(60);
        noFill();
        //box(ss*0.9);
        popMatrix();
      }
    }
  }
  for (int i = 0; i < 4; i++) {
    float xx = int(random(cc))*size;
    float yy = int(random(cc))*size;
    float zz = int(random(cc))*size;
    fill(255, 0, 0);
    box(size*0.4);
  }
  popMatrix();
}

void keyPressed() {
  if (keyCode == RIGHT) npos.x -= size;
  if (keyCode == LEFT) npos.x += size;
  if (keyCode == DOWN) npos.z -= size;
  if (keyCode == UP) npos.z += size;
}
