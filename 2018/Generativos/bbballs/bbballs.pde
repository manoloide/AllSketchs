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

  int cc = int(random(10000)*random(0.1, 1));
  for (int i = 0; i < cc; i++) {
    float ss = width/pow(2, int(map(pow(map(i, 0, cc, 0, 1), 0.8), 0, 1, 2, 8)));
    float xx = random(width*1.5);
    float yy = random(height*1.5);
    xx -= xx%ss;
    yy -= yy%ss;
    noStroke();
    arc2(xx, yy, ss, ss*1.5, 0, TWO_PI, color(0), 8, 0);

    int rnd = int(random(5));
    if (rnd == 1) {
      fill(rcol());
      arc(xx, yy, ss, ss, 0, PI);
      fill(rcol());
      arc(xx, yy, ss, ss, PI, TWO_PI);
    } else if (rnd == 2) {
      fill(rcol());
      arc(xx, yy, ss, ss, -PI*0.5, PI*0.5);
      fill(rcol());
      arc(xx, yy, ss, ss, PI*0.5, PI*1.5);
    } else if (rnd == 3) {
      fill(rcol());
      arc(xx, yy, ss, ss, PI*0.0, PI*0.5);
      fill(rcol());
      arc(xx, yy, ss, ss, PI*0.5, PI*1.0);
      fill(rcol());
      arc(xx, yy, ss, ss, PI*1.0, PI*1.5);
      fill(rcol());
      arc(xx, yy, ss, ss, PI*1.5, PI*2.0);
    } else {
      fill(rcol());
      arc(xx, yy, ss, ss, 0, TWO_PI);
    }
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

//int colors[] = {#FE4D9F, #EE1C25, #2F3293, #3CB74C, #0272BE, #BDCBD5, #FEFEFE};
//int colors[] = {#F19617, #251207, #15727F, #CEAB81, #BD3E36};
//int colors[] = {#FFDA05, #E01C54, #E92B1E, #E94F17, #125FA4, #6F84C5, #54A18C, #F9AB9D, #FFEA9F, #131423};
int colors[] = {#DE552D, #539670, #E6832E, #8CAB33, #DC738A, #EAB033, #2690DC, #EFEDEE, #242E53, #08080A};
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