int seed = int(random(999999));

void setup() {
  size(6500, 6500, P2D);
  smooth(2);
  //pixelDensity(2);

  generate();

  saveImage();
  exit();
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
  background(rcol());


  int cc = int(random(60, 220));
  for (int i = 0; i < 100; i++) {
    int col1 = getColor();
    int col2 = getColor();
    float s = width*1./int(random(3, 20));
    float x = random(width+s);
    float y = random(height+s);
    float amp = random(0.2, 0.8);
    x -= x%s;
    y -= y%s;

    noStroke();
    arc2(x, y, 0, s, 0, TAU, col2, 100, 0);

    int div = int(random(3, 120));
    int sub = int(random(2, 20));
    float ss = s/sub;
    float a = random(TWO_PI);
    float da = TWO_PI/div;
    for (int j = 0; j < div; j++) {
      arc2(x, y, s, s*2, a+da*j, a+da*(j+1), rcol(), 100, 0);
      float alp = random(100, 200)/sub;
      for (int k = 0; k < sub; k++) {
        arc2(x, y, s+ss*k, s+ss*(k+1), a+da*j, a+da*(j+1), rcol(), alp*(sub-k), 0);
      }
    }

    stroke(col1, 250);
    noFill();
    ellipse(x, y, s, s);
    noStroke();
    fill(col1, 245);
    ellipse(x, y, s*amp, s*amp);
  }
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
int colors[] = {#FF5C4E, #FF96BF, #FFECDE, #F9B521, #F58738, #00B487, #005CB5};
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