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
  //background(#0B0B0B);
  background(#EDCE5B);
  beginShape();
  fill(0, 0);
  vertex(0, 0);
  vertex(width, 0);
  fill(#837954, 40);
  vertex(width, height);
  vertex(0, height);
  endShape(CLOSE);


  noiseSeed(seed);
  randomSeed(seed);


  montains(16);
  grid(16);
  hojas(int(random(2000, 4000)*20), width*0.02, 0.4);
  huds01(16);
  ramas();
}

void grid(int cc) {
  float ss = width*1./cc;
  float det1 = random(0.01);
  float des1 = random(1000);
  rectMode(CENTER);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float xx = i*ss;
      float yy = j*ss;
      stroke(255, 40);
      fill(255, noise(des1+xx*det1, des1+yy*det1)*40);
      rect(xx, yy, ss, ss);
      rect(xx-ss*0.5, yy-ss*0.5, ss*0.12, ss*0.12);
      fill(0, 20);
      noStroke();
      rect(xx, yy, ss*0.1, ss*0.1);
    }
  }
}

void montains(int cc) {
  float ss = height*1./cc;

  float det = random(0.01);
  float des = random(1000);

  noStroke();
  for (int j = 0; j < cc; j++) {
    float dy = (j-0.5)*ss;

    //#EDCE5B#F2A021
    fill(lerpColor(#EDCE5B, #F2A021, pow(map(j, 0, cc, 0, 1), 0.5)), 240);
    stroke(255, 20);
    beginShape();
    for (int i = 0; i < width; i+=2) {
      float amp = noise(des+i*det, des+j*det);
      vertex(i, dy+amp*ss);
    }
    vertex(width, dy+ss*2);
    vertex(0, dy+ss*2);
    endShape(CLOSE);
  }
}

void ramas() {

  //for (int i = 0; i < 20; i++) {
  int cc = 8;
  float ss = width*1./cc;
  float det = random(0.01);
  float des = random(1000);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      float ix = i*ss;
      float iy = j*ss;
      float lar = random(30, 70);//int(random(200, 800));
      if (random(1) < 0.8) rama(ix, iy, det, des, lar);
    }
  }
}

void rama(float ix, float iy, float det, float des, float s) {
  float ic = random(colors.length);
  float dc = random(0.08);
  float x = ix;
  float y = iy;
  s = int(s);
  for (int k = 0; k < s; k++) {
    float ang = noise(des+x*det, des+y*det);
    ang = PI*(1.5+(noise(des+x*det, des+y*det)*0.2-0.1));
    float nx = x+cos(ang);
    float ny = y+sin(ang);
    stroke(getColor(ic+k*dc));
    strokeWeight(2);
    line(x, y, nx, ny);
    x = nx;
    y = ny;
  }
  x = ix;
  y = iy;
  for (int k = 0; k < s; k++) {
    float ang = noise(des+x*det, des+y*det)*TAU*2;
    float noi = (noise(des+x*det, des+y*det)*0.2-0.1)*min(1, map(k, 0, s*0.3, 0, 1));
    ang = PI*(1.5+(noi));
    float nx = x+cos(ang);
    float ny = y+sin(ang);
    strokeWeight(1);
    stroke(getColor(ic+k*dc));
    if (random(1) < 0.08 || k == s-1) {
      float xx = x; 
      float yy = y;
      //ellipse(xx, yy, 3, 3); 
      float da = PI*random(0.2);
      float dir = ((random(1) < 0.5)? -1 : 1);
      float ang2 = 0;
      for (int l = 0; l < s*0.6; l++) {
        float smda = constrain(pow(map(k, 0, s*0.2, 0, 1), 1.2), 0, 1);
        noi = noise(des+xx*det, des+yy*det)*2-1;
        ang2 = ang+(da*dir+noi*0.3)*smda;//PI*(*0.5;//+da*smda;
        float nxx = xx+cos(ang2);
        float nyy = yy+sin(ang2);
        stroke(getColor(ic+(k+l)*dc));
        line(xx, yy, nxx, nyy);
        if (random(1) < 0.06) {
          if (random(1) < 0.3) hoja(xx, yy, s*0.09, ang2+PI*0.2, rcol());
          if (random(1) < 0.3) hoja(xx, yy, s*0.09, ang2+PI*0.8, rcol());
        }
        xx = nxx;
        yy = nyy;
      }
      hoja(xx, yy, s*0.3, ang2+PI*random(0.4, 0.6), rcol());
    }
    x = nx;
    y = ny;
  }
}

void hojas(int c, float maxSize, float amp) {
  float det1 = random(0.02);
  float des1 = random(1000);
  float det2 = random(0.01);
  float des2 = random(1000);
  float det3 = random(0.02);
  float des3 = random(1000);
  float det4 = random(0.02)*random(0.2, 1);
  float des4 = random(1000);

  for (int i = 0; i < c; i++) {
    float x = random(width);
    float y = random(height);
    if (noise(des4+x*det4, des4+y*det4) < amp) continue;
    float s = maxSize*pow(noise(des2+x*det2, des2+y*det2), 1.6);//random(0.05, 0.2);
    float a = noise(des1+x*det1, des1+y*det1)*TAU*4;//random(TAU);
    float uc = pow(noise(des3+x*det3, des3+y*det3), 0.8)*0.7+random(0.3);
    int col = getColor(uc*colors.length);
    if (random(1) < 0.006) col = cols[int(random(cols.length))];
    hoja(x, y, s, a, col);
  }
}

void hoja(float x, float y, float s, float ang, int col) {
  float w = s*0.3;
  float h = int(s);
  pushMatrix();
  translate(x, y);
  rotate(ang);
  /*
  line(x, y, x, y-s);
   line(x-w, y-h*0.5, x+w, y-h*0.5);
   */

  float pb = 0.8;
  float px = 2.2;

  noStroke();  
  fill(col);
  for (int i = 0; i < h; i++) {
    float dx1 = sin(pow(map(i, 0, h, 0, 1), pb)*PI)*w;
    float dx2 = sin(pow(map(i+1, 0, h, 0, 1), pb)*PI)*w;
    float dy1 = pow(map(i, 0, h, 0, 1), px)*h;
    float dy2 = pow(map(i+1, 0, h, 0, 1), px)*h;
    fill(lerpColor(col, getColor(), random(0.6)*random(1)));
    beginShape();
    vertex(dx1, -i);
    vertex(dx2, -i-1);
    vertex(0, -dy2);
    vertex(0, -dy1);
    endShape(CLOSE);
  }

  col = lerpColor(col, color(0), 0.2);
  for (int i = 0; i < h; i++) {
    float dx1 = sin(pow(map(i, 0, h, 0, 1), pb)*PI)*-w;
    float dx2 = sin(pow(map(i+1, 0, h, 0, 1), pb)*PI)*-w;
    float dy1 = pow(map(i, 0, h, 0, 1), px)*h;
    float dy2 = pow(map(i+1, 0, h, 0, 1), px)*h;
    fill(lerpColor(col, getColor(), random(0.6)*random(1)));
    beginShape();
    vertex(dx1, -i);
    vertex(dx2, -i-1);
    vertex(0, -dy2);
    vertex(0, -dy1);
    endShape(CLOSE);
  }

  popMatrix();
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

void huds01(int cc) {
  float ss = width*1./cc;
  for (int i = 0; i < 8; i++) {
    float x = random(width+ss);
    float y = random(height+ss);
    x -= x%ss;
    y -= y%ss;
    float s = ss*int(random(1, 5));
    stroke(255, 2);
    arc2(x, y, s*0.6, s, 0, TAU, cols[int(random(cols.length))], 130, 0);
    fill(250);
    //ellipse(x, y, s*0.06, s*0.06);
    fill(220);
    ellipse(x, y, s*0.04, s*0.04);
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

int colors[] = {#DECFB4, #C0B394, #B0AA7C, #9DA575, #A2A879, #66775D, #45523A, #606B5A, #232D29};
int cols[] = {#FED42E, #FF84D4, #FFAFDA, #51B9FF, #2BFF6A};
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
