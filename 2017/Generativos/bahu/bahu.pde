int seed = int(random(999999));
PFont font;

void setup() {
  size(960, 960);
  smooth(8);
  pixelDensity(2);
  generate();
}

void draw() {
  //if (frameCount%40 == 0) generate();

  //render();
}

void keyPressed() {
  if (key == 's') saveImage();
  else generate();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void generate() {
  seed = int(random(999999));

  background(#303030);

  float sep = random(8, 24);
  float dh = sep*sqrt(3)/2;
  int cw = int(width/sep)+2;
  int ch = int(width/dh)+2;

  int cc = int(random(1, random(1, 1000)));
  noStroke();
  int segs[] = {3, 4, 6};
  for (int i = 0; i < cc; i++) {
    int ix = int(random(cw));
    int iy = int(random(ch));
    float xx = (ix+(iy%2)*0.5)*sep;
    float yy = iy*dh;
    float ss = sep*(int(random(1, 8))*2);
    noStroke();
    fill(rcol());
    int seg = segs[int(random(segs.length))];
    float a = (TWO_PI/6)*int(random(6));
    if (seg == 4) a = PI*0.25;
    poly(xx, yy, ss, seg, a);
  }
  strokeWeight(1);

  cc = int(random(200));
  for (int i = 0; i<cc; i++) {
    int ix = int(random(cw));
    int iy = int(random(ch));
    float xx = (ix+(iy%2)*0.5)*sep;
    float yy = iy*dh;
    float ss = sep*(int(random(1, 5))*2);

    float ax = xx; 
    float ay = yy;
    int rep = int(random(2, 100));

    int col = rcol();
    for (int j = 0; j < rep; j++) {
      float ang = TWO_PI/6*int(random(6));
      xx += cos(ang)*sep;
      yy += sin(ang)*sep;
      strokeWeight(4);
      stroke(col);
      line(ax, ay, xx, yy);
      noStroke();
      fill(col); 
      ellipse(xx, yy, sep*0.5, sep*0.5);
      ax = xx; 
      ay = yy;
    }
  }

  font = createFont("Chivo-Light.otf", dh*5, true);
  textFont(font);
  cc = int(random(20));
  for (int i = 0; i < cc; i++) {
    textSize(dh*1.4*int(random(1, 4)));
    int ix = int(random(cw));
    int iy = int(random(ch));
    float xx = (ix+(iy%2)*0.5)*sep;
    float yy = iy*dh;
    fill(rcol());
    text(random(1), xx, yy);
  }


  stroke(8, 180);
  strokeWeight(1);
  fill(6, 180);
  for (int j = 0; j < ch; j++) {
    float yy = j*dh;
    for (int i = 0; i < cw; i++) {
      float xx = (i+(j%2)*0.5)*sep;
      ellipse(xx, yy, 4, 4);
    }
  }
} 

void poly(float x, float y, float d, int seg, float a) {
  float r = d*0.5;  
  float da = TWO_PI/seg;
  beginShape(); 
  for (int i = 0; i < seg; i++) {
    float ang = a+da*i;
    vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  endShape(CLOSE);
}

int colors[] = {#F4ED1D, #D84B2F, #377740, #547CD8, #ffffff };
int rcol() { 
  return colors[int(random(colors.length))];
}
int getColor(float v) {
  v = v%(colors.length);

  int c1 = colors[int(v%colors.length)];
  int c2 = colors[int((v+1)%colors.length)];
  float m = v%1;

  //m = pow(m, 4);
  //return c1;
  return lerpColor(c1, c2, m);
}