int seed = int(random(999999));

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();
  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));
  render();
}

void render() {

  //lights();
  noiseSeed(seed);
  randomSeed(seed);
  background(10);

  translate(width/2, height/2);
  rectMode(CENTER);
  stroke(255, 50);
  noFill();
  int ite = int(random(2, random(5, 10)));
  for (int k = 0; k < ite; k++) {
    int div = int(pow(2, int(random(k, 8))));
    float ss = width*1./div;
    float sss = ss; 
    if (random(1) < 0.5) sss = ss*random(random(0.1, 0.5));
    float det = random(0.01);
    float des = random(0.1)*random(1)*random(1);
    if (random(1) < 0.3) des = 0;
    //strokeWeight(int(random(1, 4)));
    if (ss == sss) {
      pushMatrix();
      translate(-width/2, -height/2);
      for (int i = 0; i <= div; i++) {
        float dd = (i-div*0.5)*ss*2;
        line(dd, 0, dd, height);
        line(0, dd, width, dd);
      }
      popMatrix();
    } else {
      boolean rcol = random(1) < 0.05; 
      noFill();
      for (int j = 0; j < div; j++) {
        for (int i = 0; i < div; i++) {
          float xx = (i-div*0.5+0.5)*ss;
          float yy = (j-div*0.5+0.5)*ss;
          if (rcol) fill(noise(xx*det, yy*det)*255);
          xx += sign(xx)*ss*des;
          yy += sign(yy)*ss*des;
          //sss = ss*noise(xx*det, yy*det);
          rect(xx, yy, sss, sss);
        }
      }
    }
  }

  stroke(255, 220);
  noFill();
  for (int i = 0; i < 20; i++) {
    int mc = int(pow(2, 8));
    float s = width/float(mc);
    float ss = s*int(random(mc*0.8));
    int rnd = int(random(5));
    if (rnd == 0) ellipse(0, 0, ss, ss);
    else if (rnd == 1) {
      int sub = int(random(2, 60))*4;
      float r1 = ss*0.5;
      float r2 = r1+s*int(random(1, 12))*0.5;
      float da = TWO_PI/sub; 
      for (int j = 0; j < sub; j++) {
        float ang = da*j;
        float cx = cos(ang);
        float cy = sin(ang);
        line(cx*r1, cy*r1, cx*r2, cy*r2);
      }
    } else if (rnd == 2) {
      int sub = int(random(2, 60*3));
      float da = TWO_PI/sub; 
      float amp = random(0.1, 0.9);
      for (int j = 0; j < sub; j++) { 
        arc(0, 0, ss, ss, da*j, da*(j+amp));
      }
    } else if (rnd == 3) {
      float r = ss*0.5;
      int cc = int(random(3, 7));
      float da = TWO_PI/cc; 
      float des = random(TWO_PI);
      for (int j = 0; j < cc; j++) { 
        float amp = random(0.1, 0.9);
        float ang = j*da+des;
        ellipse(cos(ang)*r, sin(ang)*r, 5, 5);
      }
    } else if (rnd == 4) {
      float r = ss*0.5;
      int cc = int(random(3, 7));
      float da = TWO_PI/cc; 
      float des = random(TWO_PI);
      ArrayList<PVector> points = new ArrayList<PVector>();
      for (int j = 0; j < cc; j++) { 
        float amp = random(0.1, 0.9);
        float ang = j*da+des;
        points.add(new PVector(cos(ang)*r*amp, sin(ang)*r*amp));
      }

      pushStyle();
      fill(255, 10);
      stroke(255, 20);
      beginShape();
      for (int j = 0; j < points.size(); j++) {
        PVector p = points.get(j);
        vertex(p.x, p.y);
      }
      endShape(CLOSE);
      popStyle();

      for (int j = 0; j < points.size(); j++) {
        PVector p = points.get(j);
        ellipse(p.x, p.y, 5, 5);
        float ssss = random(8, 12);
        pushStyle();
        stroke(255, map(ssss, 8, 12, 50, 0));
        ellipse(p.x, p.y, ssss, ssss);
        popStyle();
      }
    }
  }
} 

int sign(float v) {
  if (v < 0) return -1;
  else return 1;
}

int colors[] = {#F05638, #F5C748, #3FD189, #FFB9DB, #AF8AB4, #6FC4EA, #FFFFFF, #412A50};
//int colors[] = {#45171D, #F03861, #FF847C, #FECEA8};

int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}