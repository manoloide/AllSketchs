int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {
  background(rcol());

  int cc = int(random(4, 50));
  float ss = width*1./cc;
  float sss = ss*0.2;

  noFill();
  stroke(0, 8);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      noFill();
      rect(i*ss, j*ss, ss, ss);
      if (random(1) < 0.5) {
        int rnd = int(random(2));
        if (random(1) < 0.5) fill(0);
        else fill(255);
        pushMatrix();
        translate((i+0.5)*ss, (j+0.5)*ss);
        rotate(int(random(8))*HALF_PI*0.5);
        
        ellipse(0, 0, sss, sss);
        popMatrix();
        //rect((i+0.5)*ss-sss*0.5, (j+0.5)*ss-sss*0.5, sss, sss);
      }
    }
  }

  int c2 = int(random(2, pow(cc, 1.2)*random(1)));
  noStroke();
  for (int i = 0; i < c2; i++) {
    int rnd = int(random(4));
    if (rnd == 0) {
      pushMatrix();
      /*
      translate(random(-1, 1), random(-1, 1));
       rotate(random(-0.004, 0.004));
       */
      int w = int(random(2, cc*0.5));
      int h = int(random(2, cc*0.5));
      if (random(1) < 0.5) w = 1;
      else h = 1;
      int x = int(random(1, cc-w-3));
      int y = int(random(1, cc-h-3));
      noStroke();
      fill(0, 40);
      rect(x*ss+2, y*ss +2, w*ss, h*ss);
      fill(rcol());
      rect(x*ss, y*ss, w*ss, h*ss);
      popMatrix();
    }
    if (rnd == 1) {
      int s = int(random(2, cc*0.5));
      int x = int(random(1, cc-s-1));
      int y = int(random(1, cc-s-1));
      noFill();
      strokeWeight(ss);
      ellipseMode(CORNERS);
      stroke(0, 40);
      ellipse((x+0.5)*ss+2, (y+0.5)*ss+2, (x+s-0.5)*ss, (y+s-0.5)*ss);
      ellipse((x+0.5)*ss+2, (y+0.5)*ss+2, (x+s-0.5)*ss+2, (y+s-0.5)*ss+2);
      stroke(rcol());
      ellipse((x+0.5)*ss, (y+0.5)*ss, (x+s-0.5)*ss, (y+s-0.5)*ss);
      strokeWeight(1);
      ellipseMode(CENTER);
    }
    if (rnd == 2) {
      int x = int(random(1, cc-1));
      int y = int(random(1, cc-1)); 

      int col = rcol();
      stroke(0, 40);
      for (int l = 0; l < 8; l++) {
        float dd = map(l, 0, 7, 0, ss);
        line(x*ss+dd+2, y*ss-ss*0.1+2, x*ss+dd+2, y*ss+ss*1.1+2);
        line(x*ss-ss*0.1+2, y*ss+dd+2, x*ss+ss*1.1+2, y*ss+dd+2);
      }
      stroke(col);
      for (int l = 0; l < 8; l++) {
        float dd = map(l, 0, 7, 0, ss);
        line(x*ss+dd, y*ss-ss*0.1, x*ss+dd, y*ss+ss*1.1);
        line(x*ss-ss*0.1, y*ss+dd, x*ss+ss*1.1, y*ss+dd);
      }
    }
  }

  /*
  for (int i = 0; i < 1000; i++) {
   stroke(rcol());
   noFill();
   float xx = random(width);
   float yy = random(height);
   float rr = width*random(0.01);
   float a1 = random(TAU);
   float a2 = a1+random(HALF_PI);
   ellipse(xx, yy, 5, 5);
   }
   */
}


void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, alp2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#01903B, #FEE643, #F3500A, #0066B8, #583106, #F4EEE0};
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