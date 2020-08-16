int seed = int(random(999999));
void setup() {
  size(6500, 6500, P2D);
  //smooth(8);
  //pixelDensity(2);
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
  background(0);

  int cw = int(random(14, random(20, 40)));
  int ch = int(random(14, random(20, 40)));
  float ww = width*1./cw;
  float hh = height*1./ch;

  noStroke();
  int c1 = lerpColor(getColor(), color(0), random(0.6, 1));
  int c2 = lerpColor(getColor(), color(255), random(0.6, 1));
  int c3 = getColor();
  int c4 = getColor();
  strokeCap(SQUARE);
  int rnd = int(random(3));
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      if (rnd == 0) {
        if ((i)%2 == 0) fill(c1);
        else fill(c2);
      }
      if (rnd == 1) {
        if ((j)%2 == 0) fill(c1);
        else fill(c2);
      }
      if (rnd == 2) {
        if ((i+j)%2 == 0) fill(c1);
        else fill(c2);
      }

      if (random(1) < 0.1) {
        if (random(1) < 0.5) fill(c1);
        else fill(c2);
      }

      rect(i*ww, j*hh, ww, hh);
    }
  }

  float amp = random(0.1, 0.4);
  for (int j = -1; j < ch; j++) {
    for (int i = -1; i < cw; i++) {
      if ((i+j)%2 == 0) fill(c3);
      else fill(c4);
      float xx = (i+0.5)*ww;
      float yy = (j+0.5)*hh;
      noStroke();
      rect(xx, yy, ww, hh, min(ww, hh)*amp);
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

int colors[] = {#FFFFFF, #011731, #A12677, #EE3C7A, #EE2D30, #EC4532, #FFCA2A, #3DB98A, #16A5DF};
//int colors[] = {#FE4D9F, #EE1C25, #2F3293, #3CB74C, #0272BE, #BDCBD5, #FEFEFE};
//int colors[] = {#FFFFFF, #02F602, #0056E9};
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