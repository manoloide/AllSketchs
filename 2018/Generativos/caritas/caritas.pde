int seed = int(random(999999));
float det, des;
PShader post;

void setup() {
  size(960, 960, P2D);
  smooth(2);
  pixelDensity(2);

  post = loadShader("post.glsl");

  generate();
}

void draw() {
  //generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate();
  }
}

void generate() { 

  float time = millis()*0.001;

  des = random(1000);
  det = random(0.001);

  randomSeed(seed);
  background(#FBECE7);

  noiseDetail(2);
  noStroke();
  int cc = int(random(80, 300));
  for (int i = 0; i < cc; i++) {
    float xx = random(width);
    float yy = map(i, 0, cc, 0, height*1.6);
    float ms = cos(time*random(1))*random(0.1);
    float ss = width*random(0.6);
    float fs = random(0.8, 1.4);
    yy -= map(ss, 0, width*0.6, 0.1, 4);
    ss = pow(noise(det+xx*des, det+yy*des)+(0.1+ms), 1)*width*0.5;

    fill(rcol(), 240);
    arc2(xx, yy, ss, 0, 0, TAU, getColor(), 255, 240);

    arc2(xx, yy, ss, ss*0.2, 0, TAU, rcol(), 60, 0);
    arc2(xx, yy, ss, ss*1.2, 0, TAU, color(0), 20, 0);
    arc2(xx, yy, ss, ss*1.6, 0, TAU, color(0), 20, 0);


    arc2(xx-ss*0.1, yy+ss*0.05, ss*0.1, 0, 0, TAU, color(255, 0, 0), 0, 20);
    arc2(xx+ss*0.1, yy+ss*0.05, ss*0.1, 0, 0, TAU, color(255, 0, 0), 0, 20);

    fill(0, 220);
    ellipse(xx-ss*0.1*fs, yy, ss*0.02*fs, ss*0.03*fs);
    ellipse(xx+ss*0.1*fs, yy, ss*0.02*fs, ss*0.03*fs);
    ellipse(xx, yy+ss*random(0.01, 0.03)*fs, ss*0.04, ss*0.03*random(0.4, 1.8)*fs);

    fill(255, 40);
    ellipse(xx, yy, ss*0.1, ss*0.1);
    arc2(xx, yy, ss*0.1, ss*0.4, 0, TAU, color(255), 40, 0);
  }

  post = loadShader("post.glsl");
  filter(post);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma*0.25));
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

int colors[] = {#D5EDDD, #B8E9E6, #A0A5E7, #E2B8DE, #F4CCD4};
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