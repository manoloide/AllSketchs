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
  translate(width/2, height/2, -160);
  rotateX(-PI*0.14);
  rotateY(frameCount*0.008);
  stroke(40);
  rotateX(PI/2);
  grid(22, 20);

  rotateX(-PI/2);
  /*
  int cc = 0;//int(random(3, 30));
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
   }*/

  int cc = 0;
  while (cc < 20) {
    int col = pallete[int(random(pallete.length))];
    stroke(col);
    strokeWeight(int(random(1, 3)));
    fill(col, 20);
    float xx = (cc-10);
    int sep = int(random(1, random(min(11, 20-cc))));
    float amp = random(5, 60);
    int lc = 6;
    float da = TWO_PI/lc;
    for (int i = 0; i < lc; i++) {
      beginShape();
      vertex((cc-10)*20, cos(da*i)*amp, sin(da*i)*amp);
      vertex((cc-10)*20, cos(da*(i+1))*amp, sin(da*(i+1))*amp);
      vertex((cc-10+sep)*20, cos(da*(i+1))*amp, sin(da*(i+1))*amp);
      vertex((cc-10+sep)*20, cos(da*i)*amp, sin(da*i)*amp);
      endShape(CLOSE);
      beginShape();
      vertex((cc-10)*20, cos(da*i)*amp, sin(da*i)*amp);
      vertex((cc-10)*20, cos(da*(i+1))*amp, sin(da*(i+1))*amp);
      vertex((cc-10)*20, 0, 0);
      endShape(CLOSE);
      beginShape();
      vertex((cc-10+sep)*20, cos(da*(i+1))*amp, sin(da*(i+1))*amp);
      vertex((cc-10+sep)*20, cos(da*i)*amp, sin(da*i)*amp);
      vertex((cc-10+sep)*20, 0, 0);
      endShape(CLOSE);
    }
    cc += sep;
    pushMatrix();
    translate((xx+sep/2+(sep%2)*0.5)*20, -70, 0);
    arc(0, 0, sep*20, sep*20, PI, TWO_PI);
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

