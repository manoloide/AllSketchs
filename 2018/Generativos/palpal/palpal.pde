int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);
  generate();

  //saveImage();
  //exit();
}

void draw() {
  //if (frameCount%40 == 0) generate();
  generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  randomSeed(seed);

  float time = millis()*0.001*random(0.8, 4);
  float mtime = time%1;

  background(rcol());

  ortho();
  translate(width*0.5, height*0.5);
  //rotateX(HALF_PI-atan(1/sqrt(2)));
  rotateX(time*random(-0.1, 0.1));
  rotateY(time*random(-0.1, 0.1));
  rotateZ(time*random(-0.1, 0.1));

  for (int i = 0; i < 30; i++) {
    rotateX(time*random(-0.1, 0.1));
    rotateY(time*random(-0.1, 0.1));
    rotateZ(time*random(-0.1, 0.1));

    int res = 120;
    noStroke();
    fill(rcol());
    float amp = width*random(0.05)*random(1);
    float r = width*random(1.8, 2);
    for (int j = 0; j < res; j++) {
      float a1 = map(j+0, 0, res, 0, TAU);
      float a2 = map(j+1, 0, res, 0, TAU); 

      beginShape();
      vertex(cos(a1)*r, sin(a1)*r, -amp);
      vertex(cos(a1)*r, sin(a1)*r, +amp);
      vertex(cos(a2)*r, sin(a2)*r, +amp);
      vertex(cos(a2)*r, sin(a2)*r, -amp);
      endShape(CLOSE);
    }
  }

  /*
  int orbit = int(random(10));
   for (int i = 0; i < orbit; i++) {
   pushMatrix();
   rotateX(time*random(-0.5, 0.5)*random(1));
   rotateY(time*random(-0.5, 0.5)*random(1));
   rotateZ(time*random(-0.5, 0.5)*random(1));
   translate(0, 0, width*(random(0.07, 0.1)+cos(time*random(0.2))*0.02));
   box(random(5));
   popMatrix();
   }
   
   stroke(255);
   noFill();
   strokeWeight(1);
   float r = width*0.05;
   for (int i = 0; i < 200; i++) {
   float a1 = random(TWO_PI);
   float a2 = acos(random(-1, 1));
   float xx = sin(a1)*sin(a2);
   float yy = sin(a1)*cos(a2);
   float zz = cos(a1);
   point(xx*r, yy*r, zz*r);
   }
   */
  float r = width*1.6;
  for (int i = 0; i < 200; i++) {
    float a1 = random(TWO_PI);
    float a2 = acos(random(-1, 1));
    float xx = sin(a1)*sin(a2);
    float yy = sin(a1)*cos(a2);
    float zz = cos(a1);
    point(xx*r, yy*r, zz*r);
  }

  int val = int(time);
  int cc = int(random(1, random(500)));
  float ss = width*2./cc;
  for (int i = 0; i < cc; i++) {
    fill(rcol());
    randomSeed(seed+(i-val)*1000);
    pushMatrix();
    translate(0, 0, (i+mtime-cc*0.5)*ss*2);
    float s = ss*random(40);
    if (i < 10) {
      s *= pow(map((mtime+i), 0, 10, 0, 1), 1.2);
    }

    if (i < 4) {
      float mm = pow(map((mtime+i), 0, 4, 0, 1), 1.6);
      stroke(255, 120*(1-mm));
      ellipse(0, 0, s*10, s*10);
    }

    stroke(255);
    if (random(1) < 0.8) {
      float amp = ss*0.5;
      if (i <= 3) amp *= map(i+mtime, 0, 4, 0, 1);
      if (random(1) < 0.5) line(0, 0, -amp, 0, 0, amp); 
      else point(0, 0, 0);
    }


    int rnd = int(random(8));
    if (rnd == 0) ellipse(0, 0, s, s);
    if (rnd == 1) {
      int sub = int(random(3, 33));
      float amp = random(0.1, 0.9);
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        float a2 = ang+(j+amp)*da;
        arc(0, 0, s, s, a1, a2);
      }
    }  
    if (rnd == 2) {
      int sub = int(random(3, 33));
      float amp = random(0.1, 0.9);
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        float a2 = ang+(j+amp)*da;
        arc(0, 0, s, s, a1, a2);
      }
    } 
    if (rnd == 3) {
      int sub = int(random(3, 33));
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      float r1 = s*random(0.5);
      float r2 = s*random(0.5)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        line(cos(a1)*r1, sin(a1)*r1, 0, cos(a1)*r2, sin(a1)*r2, 0);
      }
    } 
    if (rnd == 4) {
      int sub = int(random(3, 33));
      float da = TWO_PI/sub;
      float ang = random(TAU)*time*random(-0.1, 0.1)*random(1);
      float r1 = s*random(0.5);
      float amp = ss*random(0.1, 0.9)*random(1);
      for (int j = 0; j < sub; j++) {
        float a1 = ang+j*da;
        line(cos(a1)*r1, sin(a1)*r1, -amp, cos(a1)*r1, sin(a1)*r1, amp);
      }
    } 
    popMatrix();
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#FEB63F, #F29AAA, #297CCA, #003151, #E1DBDB};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor() {
  return getColor(random(colors.length));
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)];
  return lerpColor(c1, c2, v%1);
}