import peasy.*;

PeasyCam cam;
Stairway stairs[][][];
int count = 20;
float size = 100;
float thick = size*0.02;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  cam = new PeasyCam(this, 100);
  generate();
}

void draw() {
  background(0);
  ambientLight(64, 64, 64);
  directionalLight(128, 128, 128, 0, 0, -1);
  directionalLight(64, 64, 64, -0.5, -0.5, -1);
  directionalLight(32, 32, 32, 0.5, 0.5, -0.5);
  float dd = count*size*-0.5;
  translate(dd, dd, dd);
  stroke(0);
  for (int k = 0; k < count; k++) {
    for (int j = 0; j < count; j++) {
      for (int i = 0; i < count; i++) {
        if (stairs[i][j][k] != null) {
          stairs[i][j][k].show();
        }
      }
    }
  }
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String name = nf(day(), 2)+nf(hour(), 2)+nf(minute(), 2)+nf(second(), 2);
  saveFrame(name+".png");
}

void generate() {
  stairs = new Stairway[count][count][count];

  for (int i = 0; i < 40; i++) {
    int x = int(random(count)); 
    int y = int(random(count*random(1))); 
    int z = int(random(count)); 
    int d = int(random(4)); 
    boolean wall = false;

    int chances = 10;
    int nx, ny, nz;
    while (chances > 0) {
      nx = x; 
      ny = y;
      nz = z;
      if (d == 0) nx ++;
      if (d == 1) nz --;
      if (d == 2) nx --;
      if (d == 3) nz ++;
      if (!wall) ny ++;

      if (nx >= 0 && nx < count && ny >= 0 && ny < count && nz >= 0 && nz < count && stairs[nx][ny][nz] == null) {
        stairs[nx][ny][nz] = new Stairway(nx, ny, nz, d);
        if (wall) {
          stairs[nx][ny][nz].wall = true;
          d += int(random(-1, 2));
          if (d < 0) d += 4;
          if (d > 3) d -= 4;
        }
        wall = false;
        if (random(1) < 0.4) wall = true;
        x = nx; 
        y = ny; 
        z = nz;
        chances = 10;
      } else {
        chances--;
      }
    }
  }
}

class Stairway {
  boolean wall;
  int x, y, z, dir;
  Stairway(int x, int y, int z, int dir) {
    this.x = x; 
    this.y = y; 
    this.z = z; 
    this.dir = dir;
    this.wall = false;
  }

  void show() {
    pushMatrix();
    translate(x*size, y*size, z*size);
    rotateY(dir*HALF_PI);
    if (wall) {
      wallDraw(size);
    } else {
      stairwayDraw(size, 7);
    }
    popMatrix();
  }
}

void wallDraw(float s) {
  float ms = s*0.5;
  beginShape();
  vertex(-ms, ms+thick, -ms);
  vertex(ms, ms+thick, -ms);
  vertex(ms, ms+thick, ms);
  vertex(-ms, ms+thick, ms);
  endShape(CLOSE);
  beginShape();
  vertex(-ms, ms-thick, -ms);
  vertex(ms, ms-thick, -ms);
  vertex(ms, ms-thick, ms);
  vertex(-ms, ms-thick, ms);
  endShape(CLOSE);


  beginShape();
  vertex(-ms, ms+thick, -ms);
  vertex(ms, ms+thick, -ms);
  vertex(ms, ms-thick, -ms);
  vertex(-ms, ms-thick, -ms);
  endShape(CLOSE);
  beginShape();
  vertex(ms, ms+thick, -ms);
  vertex(ms, ms+thick, ms);
  vertex(ms, ms-thick, ms);
  vertex(ms, ms-thick, -ms);
  endShape(CLOSE);
  beginShape();
  vertex(ms, ms+thick, ms);
  vertex(-ms, ms+thick, ms);
  vertex(-ms, ms-thick, ms);
  vertex(ms, ms-thick, ms);
  endShape(CLOSE);
  beginShape();
  vertex(-ms, ms+thick, ms);
  vertex(-ms, ms+thick, -ms);
  vertex(-ms, ms-thick, -ms);
  vertex(-ms, ms-thick, ms);
  endShape(CLOSE);
}

void stairwayDraw(float s, int sub) {
  float ns = s/sub;
  float ms = s*0.5;
  float ix = -s*0.5;
  float iy = -s*0.5;
  for (int i = 0; i < sub; i++) {

    if (i == 0) {
      beginShape();
      vertex(ix+i*ns-thick, iy+i*ns+thick, -ms);
      vertex(ix+i*ns-thick, iy+i*ns-thick, -ms);
      vertex(ix+i*ns+thick, iy+i*ns-thick, -ms);
      endShape(CLOSE);
      beginShape();
      vertex(ix+i*ns-thick, iy+i*ns+thick, ms);
      vertex(ix+i*ns-thick, iy+i*ns-thick, ms);
      vertex(ix+i*ns+thick, iy+i*ns-thick, ms);
      endShape(CLOSE);
    }
    if (i == sub-1) {
      beginShape();
      vertex(ix+i*ns-thick, iy+i*ns+thick, -ms);
      vertex(ix+i*ns+thick, iy+i*ns+thick, -ms);
      vertex(ix+i*ns+thick, iy+i*ns-thick, -ms);
      endShape(CLOSE);
      beginShape();
      vertex(ix+i*ns-thick, iy+i*ns+thick, ms);
      vertex(ix+i*ns+thick, iy+i*ns+thick, ms);
      vertex(ix+i*ns+thick, iy+i*ns-thick, ms);
      endShape(CLOSE);
    }

    beginShape();
    vertex(ix+i*ns-thick, iy+i*ns+thick, -ms);
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, -ms);
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, +ms);
    vertex(ix+i*ns-thick, iy+i*ns+thick, +ms);
    endShape(CLOSE);
    beginShape();
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, -ms);
    vertex(ix+(i+1)*ns-thick, iy+(i+1)*ns+thick, -ms);
    vertex(ix+(i+1)*ns-thick, iy+(i+1)*ns+thick, +ms);
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, +ms);
    endShape(CLOSE);

    beginShape();
    vertex(ix+i*ns+thick, iy+i*ns-thick, -ms);
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, -ms);
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, +ms);
    vertex(ix+i*ns+thick, iy+i*ns-thick, +ms);
    endShape(CLOSE);
    beginShape();
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, -ms);
    vertex(ix+(i+1)*ns+thick, iy+(i+1)*ns-thick, -ms);
    vertex(ix+(i+1)*ns+thick, iy+(i+1)*ns-thick, +ms);
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, +ms);
    endShape(CLOSE);

    beginShape();
    vertex(ix+i*ns-thick, iy+i*ns+thick, -ms);
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, -ms);
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, -ms);
    vertex(ix+i*ns+thick, iy+i*ns-thick, -ms);
    endShape(CLOSE);
    beginShape();
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, +ms);
    vertex(ix+i*ns-thick, iy+i*ns+thick, +ms);
    vertex(ix+i*ns+thick, iy+i*ns-thick, +ms);
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, +ms);
    endShape(CLOSE);
    beginShape();
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, -ms);
    vertex(ix+(i+1)*ns-thick, iy+(i+1)*ns+thick, -ms);
    vertex(ix+(i+1)*ns+thick, iy+(i+1)*ns-thick, -ms);
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, -ms);
    endShape(CLOSE);
    beginShape();
    vertex(ix+(i+1)*ns-thick, iy+(i+1)*ns+thick, +ms);
    vertex(ix+(i+1)*ns-thick, iy+i*ns+thick, +ms);
    vertex(ix+(i+1)*ns+thick, iy+i*ns-thick, +ms);
    vertex(ix+(i+1)*ns+thick, iy+(i+1)*ns-thick, +ms);
    endShape(CLOSE);
  }
}