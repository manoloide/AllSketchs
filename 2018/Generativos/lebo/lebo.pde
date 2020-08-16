int seed = int(random(999999));

PShader noi;

void setup() {
  size(960, 960, P2D);
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


  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");
  noi.set("displace", random(100));
  shader(noi);


  int grid = int(width*1./pow(2, int(random(random(7, 8), 9))));
  float gs = width*1./grid;
  int gc = rcol();
  while (gc == back) gc = rcol();
  stroke(gc, 120);
  noFill();
  noStroke();
  for (int j = 0; j < grid; j++) {
    for (int i = 0; i < grid; i++) {
      float xx = i*gs;
      float yy = j*gs;
      fill(rcol());
      rect(xx, yy, gs, gs);
      if (random(1) < 0.08) {
        int sub = 20;
        float ss = gs/sub;
        noStroke();
        float amp = random(1)*random(0.4, 1);
        for (int l = 0; l < sub; l++) {
          for (int k = 0; k < sub; k++) {
            if(random(1) > amp) continue;
            fill(rcol());
            rect(xx+k*ss+1, yy+l*ss+1, ss-2, ss-2);
          }
        }
        noStroke();
      }
    }
  }


  for (int i = 0; i < grid*4; i++) {

    noi.set("displace", random(100));
    shader(noi);


    float xx = int(random(-1, grid*4+1))*gs*0.25;
    float yy = int(random(-1, grid*4+1))*gs*0.25;
    int col = rcol();
    float alp = random(40, 80)*0.8;
    noFill();
    noStroke();
    if (random(1) < 0.8) stroke(col);
    rect(xx, yy, gs, gs);
    noStroke();

    if (random(1) < 0.08) {
      int sub = 20;
      float ss = gs/sub;
      stroke(255);
      for (int j = 0; j < sub; j++) {
        for (int k = 0; k < sub; k++) {
          fill(rcol());
          rect(xx+k*ss, yy+j*ss, ss, ss);
        }
      }
      noStroke();
    }

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
int colors[] = {#D9BADE, #0B25A0, #2EBF40, #FCCB03, #F84D1E, #FFFFFF};
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
