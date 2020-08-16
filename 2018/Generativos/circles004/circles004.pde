int seed = int(random(999999));

PShader noi;

void setup() {
  size(3250, 3250, P3D);
  smooth(2);
  pixelDensity(2);

  noi = loadShader("noiseShadowFrag.glsl", "noiseShadowVert.glsl");
  
  strokeWeight(2);
  generate();
  
  saveImage();
  exit();
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
  background(238);

  noiseSeed(seed);
  randomSeed(seed);



  float det = random(0.01);
  float des = random(1000);
  pushMatrix();
  translate(0, 0, -20);
  noStroke();
  for (int i = 0; i < 1000000; i++) {
    float x = random(width);
    float y = random(height);
    float s = width*0.002*noise(des+x*det, des+y*det);
    fill(rcol(), 80);
    ellipse(x, y, s, s);
  }
  popMatrix();

  int cccc = int(random(80, random(120, 200))*0.6);
  for (int c = 0; c < cccc; c++) {
    float x = random(width);
    float y = random(height);
    float s = width*random(1)*random(1)*random(1);

    float s1 = random(s*0.5, s);
    fill(rcol());
    ellipse(x, y, s1, s1);

    noStroke();
    arc2(x, y, s1, s1*1.2, 0, TAU, rcol(), 30, 0);

    float a = random(TAU);
    for (int i = 0; i < 10; i++) {
      float da = i*0.026;
      arc2(x, y, s1+1, s1*1.08, a+da, a+0.02+da, rcol(), 130, 190);
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
    float a1 = random(TWO_PI);
    float amp = random(TWO_PI);
    float da = amp/ccc;
    stroke(rcol());
    for (int i = 0; i < ccc; i++) {
      float ang = a1+da*i;
      arc(x, y, s, s, ang, ang+da*random(1));
    }
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
//int colors[] = {#F4C7B2, #F4E302, #13ACF4, #03813E, #E40088};
int colors[] = {#191F5A, #5252C1, #9455F9, #FFA1FB, #FFFFFF, #51C3C4, #EE4764, #FFA1FB, #E472E8, #FFB452};
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
