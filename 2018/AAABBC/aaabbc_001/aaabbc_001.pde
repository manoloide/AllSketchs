int seed = int(random(999999));
void setup() {
  size(960, 960);
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
  background(0);

  translate(width/2, height/2);

  int cc = 5;
  float ss = 600./cc;
  float dx = ss;
  float dy = ss*sqrt(3)*0.5;
  float rr = ss*0.5;



  noFill();
  stroke(255, 120);
  float da = TWO_PI/6;
  for (int j = -cc; j <= cc; j++) {
    float y = j*dy;
    for (int i = -cc; i <= cc; i++) {
      float x = i*dx;
      if (j%2 == 0) x += dx*0.5;
      //ellipse(x, y, ss*4, ss*4);
      //ellipse(x, y, ss*3, ss*3);
      ellipse(x, y, ss*2, ss*2);
      ellipse(x, y, ss*1.2, ss*1.2);
      ellipse(x, y, ss, ss);
      ellipse(x, y, ss*0.5, ss*0.5);
      ellipse(x, y, 1, 1);
      ellipse(x, y+dy*0.5, 1, 1);
      for (int k = 0; k < 6; k++) {
        float a1 = k*da;
        float a2 = a1+da*2;
        line(x+cos(a1)*rr, y+sin(a1)*rr, x+cos(a2)*rr, y+sin(a2)*rr);
        line(x+cos(a1+da*0.5)*rr, y+sin(a1+da*0.5)*rr, x+cos(a2+da*0.5)*rr, y+sin(a2+da*0.5)*rr);

        line(x, y, x+cos(a1)*rr, y+sin(a1)*rr);
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#011731, #A12677, #EE3C7A, #EE2D30, #EC4532, #FFCA2A, #3DB98A, #16A5DF};
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