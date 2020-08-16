int seed;
int pallete[] = {
  #FCD224, 
  #D85AD7, 
  #FA3055, 
  #FFF5F7
};

void setup() {
  size(800, 600, P3D);
  generate();
}

void draw() {
  randomSeed(seed);
  background(20);
  translate(width/2, height/2, -200);
  rotateX(-PI*0.16);
  rotateY(frameCount*0.008);
  stroke(40);
  rotateX(PI/2);
  grid(20, 20);

  rotateX(-PI/2);
  int cc = int(random(3, 30));
  for (int i = 0; i < cc; i++) {
    pushMatrix();
    int col = pallete[int(random(pallete.length))];
    stroke(col);
    strokeWeight(int(random(1, 4)));
    fill(col, 20);
    int s = int(random(1, random(1, 10)));
    int x = int(random(-10+s, 10-s));
    int y = int(random(-10+s, 10-s));
    translate(x*20, 0, y*20);
    rotateY(PI*0.5*int(random(2)));
    arc(0, 0, s*40, s*40, PI, TWO_PI);
    popMatrix();
  }
}

void keyPressed() {
  generate();
}

void generate() {
  seed = int(random(999999999));
}

void grid(int cc, int sep) {
  cc /= 2; 
  strokeWeight(1);
  for (int i = -cc; i <= cc; i++) {
    line(i*sep, -cc*sep, i*sep, cc*sep);
    line(-cc*sep, i*sep, cc*sep, i*sep);
  }
}

