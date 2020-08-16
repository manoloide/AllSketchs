int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();

  /*
  saveImage();
   exit();
   */
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

class Rect {
  float x, y, w, h;
  Rect(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
}

void generate() { 

  randomSeed(seed);
  background(240);

  noStroke();
  fill(240);
  rectMode(CENTER);
  int cc = int(width/40);
  float ss = width*1./cc;
  float det = random(0.1)*random(1);
  float des = random(1000);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float x = i*ss;
      float y = j*ss;
      fill(240, noise(des+x*det, des+y*det)*50);
      rect(x, y, ss, ss);
      fill(240);
      rect(x, y, 1, 1);
    }
  }

  int col = rcol();
  for (int i = 0; i < 1000; i++) {
    float x = int(random(width));
    float y = int(random(height));
    float s = random(1)*ss;
    fill(lerpColor(color(240), rcol(), 1-pow(random(1), 0.1)*0.8), random(255)*random(1));
    rect(x, y, s, s);
      rect(x, y, s*0.2, s*0.2);
  }

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int div = int(random(180));
  for (int i = 0; i < div; i++) {
    int ind = int(random(rects.size()));
    Rect r = rects.get(ind);
    int iw = int(r.w/ss);
    int ih = int(r.h/ss);
    if (iw > 1 && ih > 1) {
      int cw = int(random(1, iw-1));
      int ch = int(random(1, ih-1));
      float nw = cw*ss;
      float nh = ch*ss;
      rects.add(new Rect(r.x, r.y, nw, nh));
      rects.add(new Rect(r.x+nw, r.y, r.w-nw, nh));
      rects.add(new Rect(r.x+nw, r.y+nh, r.w-nw, r.h-nh));
      rects.add(new Rect(r.x, r.y+nh, nw, r.h-nh));
      rects.remove(ind);
    }
  }


  des = random(0.2);
  det = random(100);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float x = i*ss;
      float y = j*ss;
      float s = pow(noise(des+x*det, des+y*det), 2)*ss*0.2;
      fill(rcol());
      rect(x, y, s, s);
    }
  }

  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    if (random(1) < 0.6) {
      noStroke();
      fill(rcol());
      rectMode(CORNER);
      rectRound(r.x, r.y, r.w, r.h, 0.1);

      rectMode(CENTER);
      stroke(255, 20);
      int c = g.fillColor;
      gridRect(r.x+10, r.y+10, r.w-10, r.h-10, 20, random(2, 12), c);

      fill(rcol());
      rect(r.x+2, r.y+2, 2, 2);
      rect(r.x+r.w-4, r.y+2, 2, 2);
      rect(r.x+r.w-4, r.y+r.h-4, 2, 2);
      rect(r.x+2, r.y+r.h-4, 2, 2);
    }
  }
  
  for(int i = 0; i < 40; i++){
     float x = random(width);
     float y = random(height);
     float s = width*random(0.4);
     stroke(255, 8);
     arc2(x, y, s*0.6, s, 0, TAU, rcol(), 50, 0);
     fill(250);
     ellipse(x, y, s*0.06, s*0.06);
     fill(rcol());
     ellipse(x, y, s*0.04, s*0.04);
  }
}

void gridRect(float x, float y, float w, float h, int des, float s, int col) {
  for (float j = 0; j < h; j+=des) {
    for (float i = 0; i < w; i+=des) {
      fill(col);
      if(random(1) < 0.01) fill(rcol());
      rect(x+i, y+j, s, s);
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

void arc2(float x, float y, float s1, float s2, float a1, float a2, int col, float alp1, float alp2) {
  float r1 = s1*0.5;
  float r2 = s2*0.5;
  float amp = (a2-a1);
  float ma = map(amp, 0, TWO_PI, 0, 1);
  int cc = max(2, int(max(r1, r2)*PI*ma));
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

void rectRound(float x, float y, float w, float h, float amp) {
  int col1 = rcol();
  int col2 = lerpColor(col1, rcol(), random(0.4));
  beginShape();
  fill(col2);
  vertex(x+w, y+h);
  vertex(x, y+h);
  fill(col1);
  vertex(x, y);
  vertex(x+w, y);
  endShape(CLOSE);
}

int colors[] = {#DEEDFE, #E0D6CC, #F0B0BA, #E46B74, #B00018, #3E97E8, #50B1FB, #90D0C2, #E2D874, #DEC93E};
//int colors[] = {#687FA1, #AFE0CD, #FDECB4, #F63A49, #FE8141};
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