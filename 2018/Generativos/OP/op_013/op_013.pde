int seed = int(random(999999));
void setup() {
  size(960, 960, P2D);
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

  int cw = int(random(8, random(20, 30)));
  int ch = int(random(8, random(20, 30)));
  ch = cw;
  float ww = width*1./cw;
  float hh = height*1./ch;

  noStroke();

  int c1 = lerpColor(getColor(), color(0), random(0.6, 1));
  int c2 = lerpColor(getColor(), color(255), random(0.6, 1));
  int c3 = getColor();
  int c4 = getColor();
  int c5 = getColor();
  int c6 = getColor();
  int c7 = getColor();
  int c8 = getColor();
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
  float des = random(10000);
  float det = random(0.05);

  float sc = random(0.3, 0.8);
  for (int j = -1; j < ch; j++) {
    for (int i = -1; i < cw; i++) {
      if ((i+j)%2 == 0) fill(c3);
      else fill(c4);
      float xx = (i+0.5)*ww;
      float yy = (j+0.5)*hh;
      float n = 0.4+noise(des+xx*det, des+yy*det)*0.6;
      noStroke();
      ellipse(xx, yy, ww*amp, hh*amp);
      //rect(xx, yy, ww, hh, min(ww, hh)*amp);
      fill(255);
      if ((i+j)%2 == 0) fill(0);
      ellipse(xx+ww*0.5, yy+hh*0.5, ww, hh);
      if ((i+j)%2 == 0) fill(c3);
      else fill(c4);
      ellipse(xx+ww*0.5, yy+hh*0.5, ww*0.5, hh*0.5);
      //eye(xx+ss*0.5, yy+ss*0.5, ss*0.48*n, ang, c5, c6, iri);

      float ss = min(ww, hh);    
      noFill();
      strokeWeight(ss*0.1);
      float a1 = random(TWO_PI);
      float a2 = a1+random(TWO_PI);
      stroke(c5);
      ellipse(xx+ww*0.5, yy+hh*0.5, ww*sc, hh*sc);
      /*
      arc(xx+ww*0.5, yy+hh*0.5, ww*sc, hh*sc, a1, a2);
       stroke(c6);
       arc(xx+ww*0.5, yy+hh*0.5, ww*sc, hh*sc, a2, a1+TWO_PI);
       */
    }
  }
}

void eye(float x, float y, float s, float a, int c1, int c2, int c3) {
  fill(c1);

  float mx = s*random(0.55, 0.64);
  float my = s*random(0.08, 0.13);

  float ah = 0.8;

  pushMatrix();
  translate(x, y);
  rotate(a);
  beginShape();
  vertex(-s, 0); // first point
  bezierVertex(-s, -my, -mx, -s*ah, 0, -s*ah);
  bezierVertex(mx, -s*ah, s, -my, s, 0);
  vertex(s, 0); // first point
  bezierVertex(s, my, mx, s*ah, 0, s*ah);
  bezierVertex(-mx, s*ah, -s, my, -s, 0);
  endShape(CLOSE);
  popMatrix();

  //ellipse(x, y, s*1.8, s*1.2);
  float amp = random(0.5, random(0.5, 0.9));
  //arc2(x, y, s, s*1.8, 0, TWO_PI, c2, 150, 0);
  fill(c2);
  ellipse(x, y, s, s);
  fill(c3);
  ellipse(x, y, s*amp, s*amp);
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