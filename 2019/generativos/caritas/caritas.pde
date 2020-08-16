int seed = int(random(999999));


float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  generate();

  if (export) {
    saveImage();
    exit();
  }
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
  noiseSeed(seed);

  background(0);
  translate(width*0.5, height*0.5);

  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));

  for (int i = 0; i < 20; i++) {
    int ind = int(random(rects.size()*random(1)));
    Rect r = rects.get(ind);
    if (r.w < 4 || r.h < 4) continue;
    rects.add(new Rect(r.x-r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y-r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x+r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.add(new Rect(r.x-r.w*0.25, r.y+r.h*0.25, r.w*0.5, r.h*0.5));
    rects.remove(ind);
  }

  noStroke();
  rectMode(CENTER);
  for (int i = 0; i < rects.size(); i++) {
    Rect r = rects.get(i);
    stroke(0, 4);
    fill(rcol(), 80);
    fill(getColor(), 250);
    rect(r.x, r.y, r.w-1, r.h-1);
    noStroke();
    fill(0, 20);
    rect(r.x, r.y, r.w*0.912, r.h*0.912);
    stroke(0, 4);
    fill(getColor(), 250);
    rect(r.x, r.y, r.w*0.9, r.h*0.90);

    for (int j = 0; j < r.w*r.h*0.2; j++) {
      float x = random(r.w*0.9);
      float y = random(random(r.h*0.9), r.h*0.9);
      stroke(255, random(50));
      point(r.x+x-r.w*0.45, r.y+y-r.h*0.45);
    }

    noStroke();

    int rnd = int(random(2)*random(1));

    if (rnd == 0) {
      int cw = int(random(random(2, 10), 21));
      int ch = int(random(random(2, 10), 21));
      cw = ch = min(cw, ch);
      float sw = r.w*0.9/cw;
      float sh = r.h*0.9/ch;
      int col1 = rcol();
      int col2 = rcol();
      int col3 = rcol();
      boolean alt = random(1) < 0.5;
      for (int yy = 0; yy < ch; yy++) {
        for (int xx = 0; xx < cw; xx++) {
          if ((xx+yy)%2 == 0) continue;
          float x = r.x-sw*(xx-cw*0.5+0.5);
          float y = r.y-sh*(yy-ch*0.5+0.5);
          fill(col1);
          if ((xx+yy)%4 == 0 && alt) fill(col3);
          rect(x, y, sw, sh);

          //fill(col2);
          //rect(x, y, sw*0.1, sh*0.1);
        }
      }
    }
    if (random(1) < 0.5) {
      float ss = min(r.w, r.h)*random(0.9);
      fill(rcol());
      ellipse(r.x, r.y, ss, ss);
    }

    for (int j = 0; j < 5; j++) {
      float s = min(r.w, r.h)*random(0.3)*random(1)*random(1);
      float x = r.x+random(-r.w*0.45+s, r.w*0.45-s);
      float y = r.y+random(-r.w*0.45+s, r.w*0.45-s); 
      fill(rcol());
      ellipse(x, y, s, s);
    }


    strokeWeight(1);
    int col = getColor();
    for (int j = 0; j < r.w*r.h*0.4; j++) {
      float x = random(r.w*0.9);
      float y = random(r.h*0.9);
      stroke(col, random(60));
      point(r.x+x-r.w*0.45, r.y+y-r.h*0.45);
    }
    noStroke();




    pushMatrix();
    float sca = random(0.7, 0.9)*1.0;
    translate(r.x, r.y+r.h*(0.45));
    scale(sca);
    translate(0, -r.h*0.45);

    float ic = random(colors.length);
    int hair = getColor(ic);


    float modVie = random(0.6)*random(0.5, 1);
    float grav = random(random(0.2), 0.6);
    float modPel = random(0.04, 0.1)*random(0.2, 0.6);

    float viento = random(TAU);
    if (random(1) < 0.95) {
      float pelo = random(0.66, 0.82)*random(0.8, 1.1);//*0.5;
      float pw = r.w*pelo;
      float ph = r.h*pelo*random(random(0.3, 0.6), random(0.6, 1.2));//*random(1, 1.2);
      fill(getColor(ic));
      //ellipse(0, -ph*random(random(0.4), 0.4), pw, ph);
      int cc = int(pw*ph*PI*random(0.06, 0.4));
      float lar = pw*random(0.2, random(0.3, random(0.5, 0.7)));
      float hp = r.h*random(0.1, 0.15);
      for (int j = 0; j < cc; j++) {
        float ang = random(TAU);
        float rot = random(TAU);
        float des = sqrt(random(1));
        float xx = cos(ang)*des*r.w*0.25;
        float yy = sin(ang)*des*r.h*0.25-hp;
        float det = random(0.04);
        noFill();
        beginShape();
        float sm = random(0.4)*random(1);
        float alp = random(250);
        float ac = random(-1.2, 1.2)*random(1);
        for (int k = 0; k < lar*random(0.7, 1); k++) {

          stroke(getColor(ic+noise(j*200+k*det)*ac), alp*random(0.5, 1));
          vertex(xx, yy);
          ang = lerp(ang, rot, sm*random(0.9, 1));
          ang = lerp(ang, viento, modVie);
          ang = lerp(ang, HALF_PI, grav);
          xx += cos(ang);
          yy += sin(ang);

          if (yy > r.h*0.45) break;
        }
        endShape();
      }
    }
    float ww = 0;
    {
      noStroke();
      fill(getColor());
      arc(0, r.h*0.455, r.w*random(0.6, 0.8), r.h*random(0.4, 0.6), PI, TAU);

      fill(0, 8);
      ellipse(r.w*0.0125, r.h*0.0125, r.w*0.575, r.h*0.625);
      fill(getColor(), 250);
      ww = r.w*random(random(0.4, 0.5), random(0.4, 0.58));
      if (random(1) < 0.99) ellipse(0, 0, ww, r.h*0.6);
      //rect(0, 0, ww, r.h*0.6, ww*0.4, ww*0.4, ww*0.5, ww*0.5);


      stroke(getColor(), 130);
      strokeWeight(1);
      ep(0, 0, ww, r.h*0.6, int(r.w*r.h*0.8));

      float ndx = r.w*random(0.02, 0.028)*random(0.6, 0.8);
      float ndy = r.h*random(0.02, 0.036);

      translate(r.w*random(-0.03, 0.03)*random(1)*random(1), r.h*random(-0.0, random(0.08)));
      scale(random(0.95, random(1, 1.6)));

      noStroke();
      fill(0, 250);
      float nariz = random(0.008, random(0.01, 0.014));
      ellipse(-ndx, +ndy, r.w*nariz, r.h*nariz);
      ellipse(+ndx, +ndy, r.w*nariz, r.h*nariz);

      float ew = random(0.16, 0.18)*random(0.9, 1)*random(0.6, 0.8);
      float eh = ew*random(0.8, 1)*random(0.7, 0.9)*random(0.8, 1);
      int iris = getColor();

      float edx = r.w*ew*random(0.55, 0.9);
      float edy = r.h*random(-0.04, -0.07);
      float rot = random(0.05, 0.2);

      float des = random(random(0.14, 0.4), random(0.14, 0.4));
      float amp = random(0.3, random(0.4, 0.54));
      float hc = random(1.4, random(1.4, 2.4));
      float iris2 = random(random(0.65, 0.8), random(0.8, 1.0));
      float pup = random(0.4, 0.7);
      eye(-edx, +edy, r.w*ew, r.h*eh, iris, -rot, des, amp, hair, hc, iris2, pup);
      eye(+edx, +edy, r.w*ew, r.h*eh, iris, +rot, des, amp, hair, hc, iris2, pup);

      fill(255, random(120, 240));
      float bw = r.w*random(0.1, 0.2)*random(0.7, 1)*0.8;
      float bh = r.h*random(0.012, random(0.03, 0.04))*random(random(0.8, 1.3));
      float by = r.h*random(0.1, 0.16)*random(0.5, 0.65);
      arc(0, by, bw, bh*random(0.2, random(1, 3)), 0, PI);

      float ba = bh*random(0.1, random(1, 1.6));
      arc(-bw*0.25, by, bw*0.5, ba, PI, TAU);
      arc(+bw*0.25, by, bw*0.5, ba, PI, TAU);
    }




    if (random(1) < 0.8) {


      modPel = random(0.04, 0.1)*random(0.2, 0.6);
      modVie = random(0.6)*random(0.5, 1);
      grav = random(random(0.4), 0.6);

      strokeWeight(0.8);
      float pelo = random(0.66, 0.82)*random(0.8, 1.1);//*0.5;
      float pw = ww*pelo;
      float ph = r.h*pelo*random(random(0.3, 0.6), random(0.6, 1.2));//*random(1, 1.4);
      fill(getColor(ic));
      //ellipse(0, -ph*random(random(0.4), 0.4), pw, ph);

      int cc = int(pw*ph*PI*random(1.1, 1.4)*2);
      float lar = pw*0.5*random(0.2, random(0.3, random(0.5, 0.7)))*random(0.5, 1)*0.6;
      float hd = random(0.26, 0.32);
      for (int j = 0; j < cc; j++) {
        float ang = random(TAU);
        float rot = random(TAU);
        float des = sqrt(random(1));
        float xx = cos(ang)*des*r.w*0.18;
        float dy = map(abs(cos(ang+HALF_PI)), 1, 0, 0, r.h*modPel);
        float yy = sin(ang)*des*r.h*0.09-r.h*hd+dy;
        float det = random(0.04);
        noFill();
        beginShape();
        float sm = random(0.4)*random(1);
        float alp = random(250);
        float ac = random(-1.2, 1.2)*random(1);
        for (int k = 0; k < lar*random(0.4, 1); k++) {

          stroke(getColor(ic+noise(j*200+k*det)*ac), alp*random(0.5, 1));
          vertex(xx, yy);
          ang = lerp(ang, rot, sm*random(0.9, 1));
          ang = lerp(ang, viento, modVie);
          ang = lerp(ang, HALF_PI, grav);
          xx += cos(ang);
          yy += sin(ang);

          if (yy > r.h*0.45) break;
        }
        endShape();
      }
    }


    popMatrix();
  }
}

void ep(float x, float y, float w, float h, int cc) {
  int col = g.strokeColor;
  for (int i = 0; i < cc; i++) {
    float a = random(TAU);
    float r = (1-sqrt(random(random(1))*random(1)*random(1)*random(1)*random(0.5, 1)))*0.5;
    stroke(col, random(50));
    point(x+cos(a)*w*r, y+sin(a)*h*r);
  }
}

void ep2(float x, float y, float w, float h, int cc) {
  int col = g.strokeColor;
  for (int i = 0; i < cc; i++) {
    float a = random(TAU);
    float r = (1-sqrt(random(random(1))*random(1)*random(1)*random(1)*random(0.5, 1)))*0.5;
    stroke(col, random(50));
    point(x+cos(a)*w*r, y+sin(a)*h*r);
  }
}

void eye(float x, float y, float w, float h, int iris, float rot, float des, float amp, int hair, float hc, float iris2, float pup) {
  pushMatrix();
  translate(x, y);

  float xr = 1;
  if (rot < 0) {
    rot *= -1;
    scale(-1, 1);
    xr = -1;
  }
  rotate(rot);
  fill(240);
  ellipse(0, 0, w, h);
  stroke(0, 30);
  ep2(0, 0, w, h, int(w*h*4));
  fill(0);

  noFill();
  stroke(hair);
  strokeWeight(w*0.025);
  arc(0, 0, w*1.2, h*hc, PI*(1+des), PI*(1+des+amp));
  strokeWeight(1);
  noStroke();
  fill(iris);
  ellipse(0, 0, h*iris2, h*iris2);
  fill(0);
  float ss = h*iris2*pup;
  ellipse(0, 0, ss, ss);
  ss *= random(0.3, 0.5);
  fill(255, random(120, 220));
  ellipse(ss*xr, -ss, ss, ss);
  popMatrix();
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
int colors[] = {#0E304E, #EDE6E3, #EFC3C3, #EF512F, #F3AB39};
int rcol() {
  return colors[int(random(colors.length))];//*random(0.6, 1))];
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
