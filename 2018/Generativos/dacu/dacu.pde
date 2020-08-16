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
  background(250);

  int cw = int(random(4, random(4, 25)));
  int ch = int(cw*random(3, 5));
  float ww = width*1./cw;
  float hh = height*1./ch;
  noStroke();
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      float xx = i*ww;
      float yy = j*hh;
      noStroke();
      fill(rcol(), 40);
      rect(xx+1, yy+1, ww-2, hh-2, 2);
      ellipse(xx+ww*0.5, yy+hh*0.5, hh*0.6, hh*0.6);
      arc2(xx+ww*0.5, yy+hh*0.5, 0, ww, 0, TAU, rcol(), 150, 0); 

      noFill();
      stroke(0, 200);
      int cc = int(random(20));
      boolean hor = random(1) < 0.5;
      for (int k = 0; k < cc; k++) {
        if (hor) {
          float x1 = random(1, ww-2);
          float x2 = random(1, ww-2);
          float amp = hh*random(0.5);
          stroke(rcol(), 50);
          //line(xx+x1, yy+1, xx+x2, yy+hh-2);
          bezier(xx+x1, yy+1, xx+x1, yy+1+amp, xx+x2, yy+hh-2-amp, xx+x2, yy+hh-2);
        } else {

          float y1 = random(1, hh-2);
          float y2 = random(1, hh-2);
          float amp = ww*random(0.5);
          stroke(rcol(), 50);
          line(xx+1, yy+y1, xx+ww-2, yy+y2);
          bezier(xx+1, yy+y1, xx+1+amp, yy+y1, xx+ww-2-amp, yy+y2, xx+ww-2, yy+y2);
        }
      }
    }
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

int colors[] = {#E70012, #D3A100, #017160, #00A0E9, #072B45};
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