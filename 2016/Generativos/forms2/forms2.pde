int pallet[] = {
  #FFE700, 
  #FE4E6E, 
  #613864, 
  #D8D7D7
};

PImage tex;

void setup() {
  size(1333, 768);
  generateTexture();
  generate();
}


void draw() {
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
  background(rcol());
  for (int i = 0; i < int(random(1, 3)); i++)
    point(width*random(0.4, 0.6), height*random(0.4, 0.6), random(60, 220), int(random(8, 92)), 0);
  blendMode(ADD);
  image(tex, 0, 0);
}

void generateTexture() {
  PGraphics gra = createGraphics(1024, 1024);
  gra.beginDraw();
  gra.background(0);
  gra.noStroke();
  for (int i = 0; i < 100; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(20, 400)*random(1)*random(1);
    gra.fill(random(120), random(1, 8));
    gra.ellipse(x, y, s, s);
  }
  gra.filter(BLUR, 8);
  gra.noFill();
  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(height);
    float s = random(8)*random(1);
    float a = random(TWO_PI);
    float an = random(PI*0.7);
    gra.strokeWeight(random(1.2));
    gra.stroke(random(255), random(10, 120));
    gra.arc(x, y, s, s, a, a+an);
  }
  gra.filter(BLUR, 0.8);
  gra.endDraw();

  tex = gra.get();
}



void point(float x, float y, float r, int cc, int lvl) {
  for (int i = 0; i < cc; i++) {
    float xx = x+randomGaussian()*r;
    float yy = y+randomGaussian()*r;
    //line(x, y, xx, yy);
    //ellipse(xx, yy, 5, 5);
    rectMode(CENTER);
    float ww = random(1, 10)*0.5;
    float hh = ww*random(0.5, 1.5);
    ww = r/ww; 
    hh = r/hh;
    int rnd = int(random(8));

    if (rnd != 3 && rnd != 4) {
      noFill();
      stroke(0, 4);
      for (int j = 4; j >= 1; j--) {
        strokeWeight(j);
        rect(xx, yy, ww, hh, 1);
      }
      noStroke();
      fill(rcol());
      rect(xx, yy, ww, hh, 1);
      fill(255, 50);
    }
    if (rnd == 0) {
      float b = random(0.05, 0.18);
      int ccc = int(random(3, 22));
      float dd = (hh-hh*b)/ccc;
      float dy = (hh-hh*b)*0.5-dd*0.4;
      float h2 = dd*random(0.6, 0.8);
      for (int j = 0; j < ccc; j++) {
        rect(xx, yy-dy+dd*j, ww-ww*b, h2);
      }
    } else if (rnd == 1) {
      float b = min(ww, hh)*random(0.01, 0.1);
      float d = dist(0, b, b, 0);
      beginShape();
      vertex(xx-ww/2, yy-hh/2);
      vertex(xx-ww/2+b, yy-hh/2);
      vertex(xx, yy-b);
      vertex(xx+ww/2-b, yy-hh/2);
      vertex(xx+ww/2, yy-hh/2);
      vertex(xx+ww/2, yy-hh/2+b);
      vertex(xx+b, yy);
      vertex(xx+ww/2, yy+hh/2-b);
      vertex(xx+ww/2, yy+hh/2);
      vertex(xx+ww/2-b, yy+hh/2);
      vertex(xx, yy+b);
      vertex(xx-ww/2+b, yy+hh/2);
      vertex(xx-ww/2, yy+hh/2);
      vertex(xx-ww/2, yy+hh/2-b);
      vertex(xx-b, yy);
      vertex(xx-ww/2, yy-hh/2+b);
      endShape();
    } else if (rnd == 2) {
      fill(rcol());
      float s = min(ww, hh)*0.5;
      ellipse(xx, yy, s, s);
    } else if (rnd == 3) {

      float s = min(ww, hh);
      noFill();
      stroke(0, 4);
      for (int j = 4; j >= 1; j--) {
        strokeWeight(j);
        ellipse(xx, yy, s, s);
      }
      fill(rcol());
      ellipse(xx, yy, s, s);
    } else if (rnd == 4) {
      int c = int(random(2, 7));
      float dd = ww*0.5;
      float ss = dd*random(0.7, 0.9);
      boolean cr = (random(1) < 0.2)? true : false;
      int l = int(random(3, 7));
      int cl = rcol();
      for (int j = 0; j < c; j++) {
        noFill();
        stroke(0, 4);
        for (int k = 4; k >= 1; k--) {
          strokeWeight(k);
          poly(xx+dd*(j-c/2.), yy, ss, l, PI*1.5);
        }
        noStroke();
        if (cr) fill(rcol());
        else fill(cl);
        poly(xx+dd*(j-c/2.), yy, ss, l, PI*1.5);
      }
    }
  }

  int childs = int(random(1, random(1, 20))-lvl*5);
  for (int i = 0; i < childs; i++) {
    float ang = random(TWO_PI);
    float dd = random(3, 5);
    float xx = x +cos(ang)*r*dd;
    float yy = y +sin(ang)*r*dd;
    //line(x, y, xx, yy);
    point(xx, yy, r*random(0.3, 1.1*random(1)), int(cc*random(0.2, 1.8)), lvl+1);
  }
}

void poly(float x, float y, float s, int c, float a) {
  float r = s*0.5;
  float da = TWO_PI/c;
  beginShape();
  for (int i = 0; i < c; i++) {
    float ang = da*i+a;
    vertex(x+cos(ang)*r, y+sin(ang)*r);
  }
  endShape(CLOSE);
}

int rcol() {
  return pallet[int(random(pallet.length))];
}