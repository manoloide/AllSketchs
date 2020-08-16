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

  int cc = int(random(2, 10)*random(0.5, 1))*2;
  float ss = width*1./cc; 

  int c1 = rcol();
  int c2 = rcol();

  int c3 = rcol(); 
  int c4 = rcol();
  /*
  c1 = color(0);
   c2 = color(255);
   c3 = color(255);
   c4 = color(0);
   */
  float amp1 = random(0.2, 0.8);
  float amp2 = 1-amp1;

  int cc1 = rcol();
  int cc2 = rcol();
  int cc3 = rcol();
  int cc4 = rcol();

  //blendMode(ADD);

  noStroke();
  rectMode(CENTER);     
  for (int j = -1; j <= cc; j++) {
    for (int i = -1; i <= cc; i++) {
      float xx = ss*(i+0.5);
      float yy = ss*(j+0.5);
      if ((i+j)%2 == 0) {
        cc1 = c1;
        cc2 = lerpColor(c1, c2, 0.05);
      } else {
        cc1 = c2;
        cc2 = lerpColor(c2, c1, 0.05);
      }

      if ((i+j)%2 == 0) {
        cc3 = c3;
        cc4 = lerpColor(c3, c4, 0.05);
      } else {
        cc3 = c4;
        cc4 = lerpColor(c4, c3, 0.05);
      }
      quad(xx, yy, ss, ss, cc1, cc2);
      quad(xx, yy, ss*amp1, ss*amp1, cc2, cc1);

      quad(xx-ss*0.5, yy-ss*0.5, ss*amp2, ss*amp2, cc4, cc3);
      quad(xx-ss*0.5, yy-ss*0.5, ss*amp2*0.5, ss*amp2*0.5, cc3, cc4);
      fill(c1);
      noStroke();
      ellipse(xx-ss*0.5, yy-ss*0.5, ss*amp2*0.25, ss*amp2*0.25);

      noFill();
      stroke(cc1);
      rect(xx-ss*0.5, yy-ss*0.5, ss*0.6, ss*0.6);
      stroke(cc2, 20);
      arc2(xx-ss*0.5, yy-ss*0.5, 0, ss, 0, TAU, c1, 20, 0);
    }
  }
}

void quad(float x, float y, float w, float h, int c1, int c2) {
  float mw = w*0.5; 
  float mh = h*0.5; 
  beginShape();
  fill(c1);
  vertex(x-mw, y-mh);
  vertex(x+mw, y-mh);
  fill(c2);
  vertex(x+mw, y+mh);
  vertex(x-mw, y+mh);
  endShape(CLOSE);
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