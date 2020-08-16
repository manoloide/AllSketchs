int seed = int(random(999999));

PShader noi;

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");

  generate();
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() {

  int back = int(rcol());

  background(back);

  noiseSeed(seed);
  randomSeed(seed);

  for (int j = 0; j < 60; j++) {
    pushMatrix();
    translate(width/2+width*random(-1, 1), height/2+height*random(-1, 1), -2000);
    noFill();
    stroke(rcol());
    rotateX(random(TAU));
    rotateY(random(TAU));
    rotateZ(random(TAU));
    box(width*0.1*random(1));
    popMatrix();
  }

  int grid = int(width*1./pow(2, int(random(random(7, 8), 9))));
  float gs = width*1./grid;
  int gc = rcol();
  while (gc == back) gc = rcol();
  stroke(gc, 120);
  noFill();
  for (int j = 0; j < grid; j++) {
    for (int i = 0; i < grid; i++) {
      rect(i*gs, j*gs, gs, gs);
    }
  }

  noStroke();
  for (int i = 0; i < grid*grid*0.1; i++) {
    float x = int(random(grid+1))*gs;
    float y = int(random(grid+1))*gs; 
    fill(rcol());
    ellipse(x+0.5, y+0.5, gs*0.1, gs*0.1);
  }


  noiseDetail(3);
  int cccc = int(random(80, random(120, 200))*0.6);
  for (int c = 0; c < cccc; c++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(1)*random(1)*random(1);

    if (random(1) < 0.4) {
      x -= x%gs;
      y -= y%gs;
    }

    float s1 = random(s*0.5, s);
    fill(rcol());
    ellipse(x, y, s1, s1);

    noStroke();
    arc2(x, y, s1, s1*1.2, 0, TAU, rcol(), 30, 0);

    float a = random(TAU);
    for (int i = 0; i < 80; i++) {
      float da = i*0.026;
      arc2(x, y, s1+1, s1*1.08, a+da, a+0.02+da, rcol(), 130, 190);
    }

    int cc = int(s1*s1*PI*0.01);
    float det = (s*0.004)*0.001;
    float adt = random(0.1, 0.2);
    float des = random(1000);
    float npv = random(0.4, 0.5);
    float a1 = random(0.9, 1);
    float a2 = random(0.9, 1);
    for (int i = 0; i < cc; i++) {
      float ang = random(TAU);
      float dis = s1*atan(random(HALF_PI))*0.45;
      float xx = x+cos(ang)*dis;
      float yy = y+sin(ang)*dis;
      float ss = random(1.6, 2.2)*1.2;
      float noi = noise(des+xx*det*a1, des+yy*det*a2)+noise(des+xx*det*a1*adt, des+yy*det*a2*adt)*0.3;
      if (noi > npv) continue;
      noStroke();
      fill(0, 120);
      ellipse(xx, yy, ss, ss);
      fill(rcol());
      ellipse(xx, yy, ss*0.8, ss*0.8);
    }


    float s2 = random(s1);
    fill(rcol());
    ellipse(x, y, s2, s2);

    noStroke();
    arc2(x, y, s2, s2*1.2, 0, TAU, rcol(), 12, 0);

    /*
    int cc = int(random(1, 6));
     for (int j = 0; j < cc; j++) {
     float a1 = random(TWO_PI);
     float a2 = a1+random(TWO_PI)*random(1);
     noStroke();
     if (random(1) < 0.5) arc(x, y, s, a1, a2, rcol(), 255, 0);
     if (random(1) < 0.5) arc2(x, y, random(s), random(2), a1, a2, rcol(), 255, 0);
     }
     */

    noFill();
    int ccc = int(random(2, random(2, 60)));
    a1 = random(TWO_PI);
    float amp = random(TWO_PI);
    float da = amp/ccc;
    stroke(rcol());
    for (int i = 0; i < ccc; i++) {
      float ang = a1+da*i;
      arc(x, y, s, s, ang, ang+da*random(1));
    }
  }


  float alp = 40;
  for (int i = 0; i < grid*4; i++) {
    float xx = int(random(grid*4+1))*gs*0.25;
    float yy = int(random(grid*4+1))*gs*0.25;
    int col = rcol();
    noFill();
    stroke(col);
    rect(xx, yy, gs, gs);
    noStroke();

    beginShape();
    fill(col, alp);
    vertex(xx+gs*1.0, yy+gs*0.0);
    vertex(xx-gs*0.0, yy+gs*0.0);
    fill(col, 0);
    vertex(xx-gs*0.2, yy-gs*0.2);
    vertex(xx+gs*1.2, yy-gs*0.2);
    endShape(CLOSE);

    beginShape();
    fill(col, alp);
    vertex(xx+gs*0.0, yy-gs*0.0);
    vertex(xx+gs*0.0, yy+gs*1.0);
    fill(col, 0);
    vertex(xx-gs*0.2, yy+gs*1.2);
    vertex(xx-gs*0.2, yy-gs*0.2);
    fill(col, 80);
    endShape(CLOSE);

    beginShape();
    fill(col, alp);
    vertex(xx-gs*0.0, yy+gs*1.0);
    vertex(xx+gs*1.0, yy+gs*1.0);
    fill(col, 0);
    vertex(xx+gs*1.2, yy+gs*1.2);
    vertex(xx-gs*0.2, yy+gs*1.2);
    endShape(CLOSE);

    beginShape();
    fill(col, alp);
    vertex(xx+gs*1.0, yy+gs*1.0);
    vertex(xx+gs*1.0, yy-gs*0.0);
    fill(col, 0);
    vertex(xx+gs*1.2, yy-gs*0.2);
    vertex(xx+gs*1.2, yy+gs*1.2);
    endShape(CLOSE);

    ellipse(xx+gs*0.5, yy+gs*0.5, gs*0.1, gs*0.1);
  }
}
void arc(float x, float y, float s, float a1, float a2, int col, float alp1, float alp2) {
  float r = s*0.5;
  float amp = (a2-a1)%TWO_PI;
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(r*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, alp1);
    vertex(x, y);
    fill(col, alp2);
    vertex(x+cos(ang)*r, y+sin(ang)*r);
    vertex(x+cos(ang+da)*r, y+sin(ang+da)*r);
    endShape(CLOSE);
  }
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

//int colors[] = {#100D93, #DF390C};
int colors[] = {#80CCE9, #2C62B3, #2EBF40, #FDEB02, #F84D1E, #FFFFFF};
int rcol() {
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}
