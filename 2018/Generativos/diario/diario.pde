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

  randomSeed(seed);

  background(lerpColor(color(240), rcol(), 0.2));
  //background(rcol());

  int cc = int(random(20, 29));
  float ss = width*1./cc;
  int c1 = rcol();
  int c2 = rcol();
  noStroke();
  rectMode(CENTER);
  for (int j = 0; j <= cc; j++) {
    for (int i = 0; i <= cc; i++) {
      fill(c1);
      rect(i*ss, j*ss, ss-2, ss-2, 3);
      fill(c2);
      if(random(1) < 0.1) ellipse(i*ss, j*ss, ss*0.4, ss*0.4);
    }
  }

  for (int i = 0; i < width*height; i++) {
    stroke(random(256), random(16));
    point(random(width), random(height));
  }

  for (int i = 0; i < 30; i++) {
    float x = random(width);
    float y = random(height);
    float w = width*random(0.04, random(0.2));
    float h = height*random(0.04, random(0.2));
    pushMatrix();
    translate(x, y);
    rotate(random(TAU));
    noStroke();
    fill(rcol());
    rect(0, 0, w, h);
    for (int j = 0; j < w*h*2; j++) {
      float xx = w*random(-0.5, 0.5);
      float yy = h*random(-0.5, 0.5);
      stroke(rcol(), random(20)); 
      point(xx, yy);
    }
    popMatrix();
  }

  /*
  int cw = int(random(8, 33));
   int ch = int(random(8, 33));
   float ww = width*1./cw;
   float hh = height*1./ch;
   float ar = ww*hh;
   for(int j = 0; j <= ch; j++){
   for(int i = 0; i <= cw; i++){
   int c1 = rcol();
   int c2 = rcol();
   while(c1 == c2) c2 = rcol();
   fill(c1);
   noStroke();
   rect(i*ww, j*hh, ww, hh);
   for(int k = 0; k < ar; k++){
   stroke(255, random(60));
   float xx = (i+random(1)*random(0.5, 1))*ww;
   float yy = (j+random(0.5)*random(0.5, 1))*hh;
   point(xx, yy);
   }
   for(int k = 0; k < ar*3; k++){
   stroke(c2, random(120));
   float xx = (i+random(1))*ww;
   float yy = (j+random(random(1), 1))*hh;
   point(xx, yy);
   }
   }
   }
   */

  float cx = width*0.5;
  float cy = height*0.7;
  //int cc = 4000;
  /*
  for (int j = 0; j < cc; j++) {
   float dy = pow(map(j, 0, cc, 0, 1), 10.2);
   cx = width*random(1);
   cy = dy*height*1.1;
   float r = width*sqrt(random(1))*random(0.05, 0.4)*random(0.2, 0.5)*(0.2+dy*0.8);
   pelis(cx, cy, r, -HALF_PI);
   }
   */

  for (int i = 0; i < 5; i++) {
    cx = random(width);
    cy = random(height);

    cx -= cx%ss;
    cy -= cy%ss;

    float s = width*random(0.05, 0.2);
    int col = rcol();

    noStroke();
    fill(col);
    ellipse(cx, cy, s, s);
    arc2(cx, cy, s, s*1.6, 0, TAU, color(0), 12, 0);
    arc2(cx, cy, s, s*1.1, 0, TAU, color(0), 4, 0);

    float area = s*s*0.5*PI;
    for (int j = 0; j < area; j++) {
      float a = random(TAU);
      float r1 = sqrt(random(random(random(0.5), 1), 1));
      float d = s*r1*0.5;
      stroke(0, random(40));
      point(cx+cos(a)*d, cy+sin(a)*d);
    }

    for (int j = 0; j < area*0.6; j++) {
      float a = random(TAU);
      float r1 = 1+(1-sqrt(random(1)))*0.5;
      float d = s*r1*0.5;
      stroke(col, random(40));
      point(cx+cos(a)*d, cy+sin(a)*d);
    }
    /*
    noStroke();
     arc2(cx, cy, s*1.5, s*2, 0, TAU, color(255), 0, 40);
     for (int j = 0; j < area*2; j++) {
     float a = random(TAU);
     float r1 = 1+sqrt(random(random(1), 1));
     float d = s*r1*0.5;
     stroke((random(1) < 0.5)? 0 : 255, random(40));
     point(cx+cos(a)*d, cy+sin(a)*d);
     }
     */
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

int colors[] = {#000000, #ffffff, #807DDB, #ED829D, #E8D84E, #F23E35, #4B13C4, #6D915F};
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