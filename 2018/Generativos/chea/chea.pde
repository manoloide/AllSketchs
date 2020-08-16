int seed = int(random(999999));

void setup() {
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

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

  randomSeed(seed);
  noiseSeed(seed);
  background(rcol());

  rectMode(CENTER);
  noFill();
  for (int i = 0; i < 10; i++) {
    float x1 = random(width);
    float y1 = random(height);
    float x2 = random(width);
    float y2 = random(height);
    int col = rcol();
    stroke(col, 10);
    line(x1, y1, x2, y2);
    float ang1 = random(TAU*10);
    float ang2 = random(TAU*10);
    float dist = dist(x1, y1, x2, y2);
    int cc = int(dist*2);
    float amp1 = random(200);
    float amp2 = random(200);
    float alp1 = random(40)*random(1);
    float alp2 = random(40)*random(1);
    for (int j = 0; j <= cc; j++) {
      float v = map(j, 0, cc, 0, 1);
      stroke(col, lerp(alp1, alp2, v));
      pushMatrix();
      translate(lerp(x1, x2, v), lerp(y1, y2, v));
      rotate(lerp(ang1, ang2, v));
      float amp = lerp(amp1, amp2, v);
      rect(0, 0, amp, amp);
      popMatrix();
    }
  }
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(8, int(max(r1, r2)*PI*ma));
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

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
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
