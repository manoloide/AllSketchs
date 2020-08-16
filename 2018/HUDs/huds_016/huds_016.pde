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
  background(0);

  blendMode(ADD);

  int cg = int(random(4, 60))*2;
  float sg = width*1./cg;
  for (int j = 0; j < cg; j++) {
    for (int i = 0; i < cg; i++) {
      noStroke();
      fill(255, 40);
      rect(i*sg-1, j*sg-1, 2, 2);
    }
  }

  rectMode(CENTER);

  for (int k = 0; k < 20; k++) {
    int div = int(random(4, 12));
    int sub = int(random(10, 20));

    float r1 = width*random(0.05, 0.2);
    float r2 = width*random(0.36, 0.48);

    float da = TWO_PI/sub;

    noStroke();
    float pwr = random(0.4, 2.2);
    for (int j = 0; j < div; j++) {
      float rr = map(pow(map(j, 0, sub, 0, 1), pwr), 0, 1, r1, r2);
      color col = rcol();
      float max = random(30);
      arc2(width/2, height/2, rr*2, rr*1.8, 0, TAU, col, 40, 0);
      for (int i = 0; i < sub; i++) {
        float xx = width/2.+cos(da*i)*rr;
        float yy = height/2.+sin(da*i)*rr;
        float ss = max*random(1)*random(1);
        arc2(xx, yy, ss, 0, 0, TAU, col, 200, 0);
      }
    }
  }
}
void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(1, int(max(r1, r2)*PI*ma));
  float da = amp/cc;
  for (int i = 0; i < cc; i++) {
    float ang = a1+da*i;
    beginShape();
    fill(col, shd1);
    vertex(x+cos(ang)*r1, y+sin(ang)*r1);
    vertex(x+cos(ang+da)*r1, y+sin(ang+da)*r1);
    fill(col, shd2);
    vertex(x+cos(ang+da)*r2, y+sin(ang+da)*r2);
    vertex(x+cos(ang)*r2, y+sin(ang)*r2);
    endShape(CLOSE);
  }
}

int colors[] = {#EE3425, #000000, #D3D3D3, #FEFEFE};
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