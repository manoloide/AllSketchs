int seed;
int paleta[] = {
  #490A3D, 
  #BD1550, 
  #E97F02, 
  #F8CA00, 
  #8A9B0F
};

void setup() {
  size(600, 600, P3D);
}

void draw() {
  randomSeed(seed);
  drawing();
}

void keyPressed() {
  seed = int(random(99999999));
}

int rcol() {
  return paleta[int(random(paleta.length))];
}

void drawing() {
  background(paleta[0]);
  /*
  stroke(255, 30);
  strokeWeight(8);
  for(int i = -(frameCount/2)%20; i < width+height; i+=20){
     line(i, -2, -2, i); 
  }
  */
  translate(width/2, height/2);
  pushMatrix();
  int cc = int(random(3, 13));
  for (int i = 0; i < cc; i++) {
    pushMatrix();
    rotateX(random(TWO_PI)+frameCount*random(0.06)*random(1));
    rotateY(random(TWO_PI)+frameCount*random(0.06)*random(1));
    rotateZ(random(TWO_PI)+frameCount*random(0.06)*random(1));
    float t = random(40, 580);
    int r = int(random(3));
    noFill();
    stroke(paleta[int(random(1, paleta.length))]);
    if (r == 0) {
      strokeWeight(random(1, 16));
      ellipse(0, 0, t, t);
    } else if (r == 1) {
      strokeWeight(random(1, 8));
      int c = int(random(3, 30));
      float da = TWO_PI/c;
      for (int j = 0; j < c; j++) {
        arc(0, 0, t, t, da*j, da*(j+0.5));
      }
    }
    popMatrix();
  }
  popMatrix();
}

