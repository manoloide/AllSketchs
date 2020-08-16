int seed = int(random(999999));
PImage noise;

void setup() {
  //size(1280, 960, P3D);
  //size(640, 480, P3D);
  size(960, 960, P3D);
  smooth(8);
  pixelDensity(2);

  textureMode(NORMAL);
  createNoise();

  generate();
}

void draw() {
  //if (frameCount%60 == 0) generate();
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    generate();
  }
}

void generate() {
  seed = int(random(999999));
  color back = rcol(sky);
  background(back);
  randomSeed(seed);


  float uh = random(0.2, 0.36);
  float hh = height*uh;


  hint(DISABLE_DEPTH_TEST);

  noStroke();
  for (int c = 0; c < 3; c++) {
    beginShape();
    fill(back, 0);
    vertex(0, 0);
    vertex(width, 0);
    fill(lerpColor(back, rcol(colors), 0.5));
    vertex(width, hh);
    vertex(0, hh);
    endShape(CLOSE);
    for (int i = 0; i < 1000; i++) {
      float x = random(width);
      float y = random(hh);
      float s = random(2)*random(1);
      fill(rcol(colors));
      ellipse(x, y, s, s);
    }

    for (int i = 0; i < 5; i++) {
      float s = width*random(0.1, 0.6)*random(1);
      float x = random(width);
      float y = random(-s, hh  +s);
      noStroke();
      arc2(x, y, s, s*2.6, 0, TWO_PI, color(0), map(s, 0, width, 0, 80), 0);
      int col = lerpColor(rcol(colors), back, 0.6);
      fill(col);
      ellipse(x, y, s, s);
      arc2(x, y, s*0.4, s, 0, TWO_PI, color(0), 0, 20);
      arc2(x, y, s*0.0, s, 0, TWO_PI, color(0), 0, 30);
      arc2(x, y, s*0.8, s, 0, TWO_PI, color(col), 0, 80);
      arc2(x, y, s*1.1, s, 0, TWO_PI, color(col), 0, 40);
      //arc2(x, y, s*2, s, 0, TWO_PI, color(col), 0, 40);
    }

    beginShape();
    fill(back, 0);
    vertex(0, 0);
    vertex(width, 0);
    fill(back, random(60, 110));
    vertex(width, hh);
    vertex(0, hh);
    endShape(CLOSE);
  }

  //stroke(0, 80);
  fill(lerpColor(color(0), back, 0.5), 250);
  float des = random(10000);
  float det = random(0.01);
  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(hh);
    if (noise(des+x*det, des+y*det) < 0.6) continue;
    float r = random(2, 6)*random(0.1, 1);
    float ang = random(-0.3, 0.3);

    float hdx = cos(ang+0)*r;
    float hdy = sin(ang+0)*r;
    float vdx = cos(ang+HALF_PI)*r;
    float vdy = sin(ang+HALF_PI)*r;
    float dy = random(-0.2, 0.2);
    beginShape();
    vertex(x-hdx, y-hdy);
    vertex(x-hdx*0.5, y-hdy*0.5);
    vertex(x+vdx*(0.15+dy), y+vdy*(0.15+dy));
    vertex(x+hdx*0.5, y+hdy*0.5);
    vertex(x+hdx, y+hdy);
    vertex(x+hdx*0.5+vdx*0.05, y+hdy*0.5+vdy*0.05);
    vertex(x+vdx*(0.3+dy), y+vdy*(0.3+dy));
    vertex(x-hdx*0.5+vdx*0.05, y-hdy*0.5+vdy*0.05);
    //vertex(x, y-10);
    endShape(CLOSE);
  }
  noStroke();

  for (int j = 0; j < 3; j++) {
    det = random(0.005, 0.03)*random(0.1, 1);
    fill(lerpColor(getColor(sand), back, 0.7));
    beginShape();
    vertex(0, height*(uh+0.02));
    for (int i = 0; i <= width; i++) {
      float h = height*(uh+0.01-noise(i*det)*0.02);
      vertex(i, h);
    }
    vertex(width, height*(uh+0.02));
    endShape(CLOSE);
  }

  for (int j = 0; j < 4; j++) {
    createNoise();
    float alp = map(j, 0, 4, 255, 0);
    int sub = 20;
    int ac1 = rcol(sand);
    int ac2 = rcol(sand);
    for (int i = 0; i < sub; i++) {
      float y1 = pow(map(i, 0, sub, 0, 1), 3);
      float y2 = pow(map(i+1, 0, sub, 0, 1), 3);
      float f1 = 0.24-y1*0.4; 
      float f2 = 0.24-y2*0.4;
      y1 = map(y1, 0, 1, hh, height);
      y2 = map(y2, 0, 1, hh, height);
      beginShape();
      texture(noise);
      tint(lerpColor(ac1, back, f1), alp);
      vertex(0, y1, 0, 0);
      tint(lerpColor(ac2, back, f1), alp);
      vertex(width, y1, 1, 0);
      ac1 = rcol(sand);
      ac2 = rcol(sand);
      tint(lerpColor(ac2, back, f2), alp);
      vertex(width, y2, 1, 1);
      tint(lerpColor(ac1, back, f2), alp);
      vertex(0, y2, 0, 1);
      endShape(CLOSE);
    }
  }

  beginShape();
  fill(back, 0);
  vertex(0, hh*1.4);
  vertex(width, hh*1.4);
  fill(back, 100);
  vertex(width, hh);
  vertex(0, hh);
  endShape(CLOSE);

  ArrayList<PVector> holes = new ArrayList<PVector>();

  int ccc = 600;
  for (int i = 0; i < ccc; i++) {
    float x = random(width);
    float dy = pow(map(i, 0, ccc, 0, 1), 10);
    float y = height*map(dy, 0, 1, uh, 1);
    float ss = dy*60*1.2;

    boolean add = true;
    for (int j = 0; j < holes.size(); j++) {
      PVector h = holes.get(j);
      if (dist(x, y*4, h.x, h.y*4) < (h.z+ss)*3) {
        add = false;
        break;
      }
    }

    if (add) holes.add(new PVector(x, y, ss));
  }

  for (int i = 0; i < holes.size(); i++) {
    PVector h = holes.get(i);
    float s1 = h.z*4;
    float s2 = h.z;

    if (random(1) < 0) {
      fill(0, 250);
      //noFill();
      //stroke(0);
      fill(lerpColor(rcol(sand), color(0), 0.8));
      ellipse(h.x, h.y, s1, s2);

      holeGrad(h.x, h.y, s1, s2, 0, color(0), 200);
      holeGrad(h.x, h.y, s1, s2, -HALF_PI, color(0), 80);

      float s = h.z;
      fill(lerpColor(color(#EEF9D1), rcol(colors), 0.01));
      triangle(h.x, h.y-s*0.25, h.x-s, h.y-s*3.5, h.x+s, h.y-s*3.5);
    } else {
      if (s1 < 60) {
        /*
        fill(rcol(cactus));
         rect(h.x-s2*0.5, h.y-s1*0.5, s2, s1);
         ellipse(h.x, h.y-s1*0.5, s2, s2);
         ellipse(h.x, h.y+s1*0.5, s2, s2*0.3);
         */
        cactus2(h.x, h.y, s1);
      } else {
        cactus(h.x, h.y, s1);
      }
    }
  }

  beginShape();
  fill(back, 0);
  vertex(0, hh*6);
  vertex(width, hh*6);
  fill(back, 20);
  vertex(width, hh);
  vertex(0, hh);
  endShape(CLOSE);


  /*
  pushMatrix();
   
   hint(ENABLE_DEPTH_TEST);
   translate(random(width), height/2);
   rotateX(-PI*0.105);
   rotateY(random(-0.06, 0.06));
   
   ambientLight(128, 128, 128);
   directionalLight(128, 128, 128, 0, 0.8, -1);
   lightFalloff(1, 0, 0);
   
   for (int c = 0; c < 50; c++) {
   int cw = int(random(4, 20)); 
   int ch = int(random(random(4, 10), 40)); 
   float dd = width*0.5/max(cw, ch);
   pushMatrix();
   translate(-cw*dd*0.5+random(-width, width), -ch*dd*0.5+random(-height, height), random(-2000)); 
   noStroke();
   float h = random(-100, 100);
   float amp = random(0.4, 0.9);
   for (int j = -ch; j <= 0; j++) {
   for (int i = 0; i <= cw; i++) {
   pushMatrix();
   translate(i*dd, h, j*dd);
   fill(rcol(colors));
   box(dd*amp);
   popMatrix();
   }
   }
   popMatrix();
   }
   popMatrix();
   */


  tint(255, 18);
  image(noise, 0, 0, width, height);

  /*
  loadPixels();
   int w = width*2;
   int h = height*2;
   float r, g, b, x, y, v;
   for (int i = 0; i < pixels.length; i++) {
   x = (i%w)*1./w;
   y = (i/w)*1./h;
   v = pow(1-dist(0.5, 0.5, x, y)*1.1, 0.8);
   color aux = pixels[i]; 
   r = red(aux)/255.;
   g = green(aux)/255.;
   b = blue(aux)/255.;
   
   r = r*0.8+pow(r, 8.2)*10.6;
   g = g*0.8+pow(g, 8.2)*10.6;
   b = b*0.8+pow(b, 8.2)*10.6;
   
   pixels[i] = color(r*255, g*255, b*255);
   }
   updatePixels();
   */
}

void holeGrad(float x, float y, float w, float h, float a, int col, float alp) {
  float r1 = w*0.5;
  float r2 = h*0.5;

  int sub = int(max(r1, r2)*HALF_PI*0.2);
  float da = TWO_PI/sub;
  beginShape();
  float ang;
  for (int i = 0; i < sub; i++) {
    ang = da*i;
    fill(col, map(cos(ang+a), -1, 1, 0, alp));
    vertex(x+cos(ang)*r1, y+sin(ang)*r2);
  }
  endShape(CLOSE);
}

void createNoise() {
  noise = createImage(1920, 1920, RGB);
  noise.loadPixels();
  for (int i = 0; i < noise.pixels.length; i++) {
    noise.pixels[i] = color(random(140, 255));
  }
  noise.updatePixels();
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

void arc3(float x, float y, float s1, float s2, float a1, float a2, int col, float shd1, float shd2) {
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

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}

//int colors[] = {#D5D3D4, #CF78AF, #DA3E0F, #068146, #424BC5, #D5B307};
int colors[] = {#FACD00, #FB4F00, #F277C5, #7D57C6, #00B187, #3DC1CD};
int sand[] = {#95694C, #7F5532, #A96A3E, #815317, #4C311C};
int sky[] = {#B4AFBD, #8D98B7, #4772A0, #2C5D92, #1D4C7C};
int cactus[] = {#37493E, #3C4A2D, #17240F};

int rcol(int colors[]) {
  return colors[int(random(colors.length))];
}
int getColor(int colors[]) {
  return getColor(colors, random(colors.length));
}
int getColor(int colors[], float v) {
  v = abs(v);
  v = v%(colors.length); 
  int c1 = colors[int(v%colors.length)]; 
  int c2 = colors[int((v+1)%colors.length)]; 
  return lerpColor(c1, c2, v%1);
}

void cactus(float x, float y, float ss) {
  float aaa = PI*random(1.49, 1.51);
  float x1 = x;
  float y1 = y;
  float x2 = x+cos(aaa)*ss;
  float y2 = y+sin(aaa)*ss;
  float s = ss*random(0.1, 0.2);

  float r = s*0.5;
  float ang = random(TWO_PI);
  float dis = dist(x1, y1, x2, y2)*random(0.04);
  float cx = lerp(x1, x2, 0.5)+cos(ang)*dis;
  float cy = lerp(y1, y2, 0.5)+sin(ang)*dis;
  ArrayList<PVector> ps = new ArrayList<PVector>();
  ps.add(new PVector(x1, y1));
  ps.add(new PVector(cx, cy));
  ps.add(new PVector(x2, y2));
  Spline spline = new Spline(ps);

  cactusShadow(x1, y1, x1+cos(aaa-PI*0.4)*ss*1.6, y1+sin(aaa-PI*0.4)*ss*1.6, s, 14, 0);


  int c2 = rcol(cactus);
  int c1 = lerpColor(c2, color(0), 0.3);
  int c3 = lerpColor(c2, color(255), 0.2);

  int cc = int(spline.length/20);
  noFill(); 
  noStroke();
  for (int i = 0; i < cc; i++) {
    float v1 = map(i+0, 0, cc, 0, 1);
    float v2 = map(i+1, 0, cc, 0, 1);
    PVector p1 = spline.getPoint(v1);
    PVector p2 = spline.getPoint(v2);
    float a1 = spline.getAngle(v1)-HALF_PI;
    float a2 = spline.getAngle(v2)-HALF_PI;
    if (i == cc-1) a2 += PI;
    beginShape();
    fill(c1);
    vertex(p1.x+cos(a1)*r, p1.y+sin(a1)*r);
    vertex(p2.x+cos(a2)*r, p2.y+sin(a2)*r);
    fill(c2);
    vertex(p2.x, p2.y);
    vertex(p1.x, p1.y);
    endShape();

    beginShape();
    fill(c3);
    vertex(p1.x+cos(a1+PI)*r, p1.y+sin(a1+PI)*r);
    vertex(p2.x+cos(a2+PI)*r, p2.y+sin(a2+PI)*r);
    fill(c2);
    vertex(p2.x, p2.y);
    vertex(p1.x, p1.y);
    endShape();
  }

  float a1 = spline.getAngle(0.0)+HALF_PI;
  float a2 = spline.getAngle(0.99)+HALF_PI;
  int rc = max(4, int(r*PI));
  float da = PI/rc;
  for (int i = 0; i < rc; i++) {
    float v1 = map(i, 0, rc, 0, 1);
    float v2 = map(i+1, 0, rc, 0, 1);
    float aa1 = a2-da*(i+0)+PI;
    float aa2 = a2-da*(i+1)+PI;
    beginShape();
    fill(255, 0, 0);
    if (v1 < 0.5) fill(lerpColor(c3, c1, map(v1, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x2+cos(aa1)*r, y2+sin(aa1)*r);
    if (v2 < 0.5) fill(lerpColor(c3, c1, map(v2, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x2+cos(aa2)*r, y2+sin(aa2)*r);
    fill(c2);
    vertex(x2, y2);
    endShape();
  }


  for (int i = 0; i <= rc; i++) {
    float v1 = map(i, 0, rc, 1, 0);
    float v2 = map(i+1, 0, rc, 1, 0);
    float aa1 = a1-da*(i+0)+PI;
    float aa2 = a1-da*(i+1)+PI;
    float amp1 = map(abs(i-rc*0.5), 0, rc*0.5, 0.8, 1);
    float amp2 = map(abs(i+1-rc*0.5), 0, rc*0.5, 0.8, 1);
    amp1 = pow(amp1, 0.8);
    amp2 = pow(amp2, 0.8);
    beginShape();
    fill(255, 0, 0);
    if (v1 < 0.5) fill(lerpColor(c3, c1, map(v1, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x1+cos(aa1)*r, y1+sin(aa1)*r*amp1);
    if (v2 < 0.5) fill(lerpColor(c3, c1, map(v2, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x1+cos(aa2)*r, y1+sin(aa2)*r*amp2);
    fill(c2);
    vertex(x1, y1);
    endShape();
  }
}

void cactus2(float x, float y, float ss) {

  float aaa = PI*random(1.49, 1.51);
  float x1 = x;
  float y1 = y;
  float x2 = x+cos(aaa)*ss;
  float y2 = y+sin(aaa)*ss;
  float s = ss*random(0.1, 0.2);

  int c2 = rcol(cactus);
  int c1 = lerpColor(c2, color(0), 0.3);
  int c3 = lerpColor(c2, color(255), 0.2);

  float r = s*0.5;
  float ang = atan2(y2-y1, x2-x1);

  cactusShadow(x1, y1, x1+cos(aaa-PI*0.4)*ss*1.6, y1+sin(aaa-PI*0.4)*ss*1.6, s, 14, 0);

  beginShape();
  fill(c3);
  vertex(x1+cos(ang+HALF_PI)*r, y1+sin(ang+HALF_PI)*r);
  vertex(x2+cos(ang+HALF_PI)*r, y2+sin(ang+HALF_PI)*r);
  fill(c2);
  vertex(x2, y2);
  vertex(x1, y1);
  endShape();

  beginShape();
  fill(c2);
  vertex(x1, y1);
  vertex(x2, y2);
  fill(c1);
  vertex(x2+cos(ang-HALF_PI)*r, y2+sin(ang-HALF_PI)*r);
  vertex(x1+cos(ang-HALF_PI)*r, y1+sin(ang-HALF_PI)*r);
  endShape();

  int rc = max(4, int(r*PI));
  float da = PI/rc;
  for (int i = 0; i < rc; i++) {
    float v1 = map(i, 0, rc, 0, 1);
    float v2 = map(i+1, 0, rc, 0, 1);
    float aa1 = ang-da*(i+0)+HALF_PI;
    float aa2 = ang-da*(i+1)+HALF_PI;
    beginShape();
    fill(255, 0, 0);
    if (v1 < 0.5) fill(lerpColor(c3, c1, map(v1, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x2+cos(aa1)*r, y2+sin(aa1)*r);
    if (v2 < 0.5) fill(lerpColor(c3, c1, map(v2, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x2+cos(aa2)*r, y2+sin(aa2)*r);
    fill(c2);
    vertex(x2, y2);
    endShape();
  }


  for (int i = 0; i <= rc; i++) {
    float v1 = map(i, 0, rc, 1, 0);
    float v2 = map(i+1, 0, rc, 1, 0);
    float aa1 = ang-da*(i+0)-HALF_PI;
    float aa2 = ang-da*(i+1)-HALF_PI;
    float amp1 = map(abs(i-rc*0.5), 0, rc*0.5, 0.8, 1);
    float amp2 = map(abs(i+1-rc*0.5), 0, rc*0.5, 0.8, 1);
    amp1 = pow(amp1, 0.8);
    amp2 = pow(amp2, 0.8);
    beginShape();
    fill(255, 0, 0);
    if (v1 < 0.5) fill(lerpColor(c3, c1, map(v1, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x1+cos(aa1)*r, y1+sin(aa1)*r*amp1);
    if (v2 < 0.5) fill(lerpColor(c3, c1, map(v2, 0, 0.5, 0, 1)));
    else fill(c1);
    vertex(x1+cos(aa2)*r, y1+sin(aa2)*r*amp2);
    fill(c2);
    vertex(x1, y1);
    endShape();
  }
}


void cactusShadow(float x1, float y1, float x2, float y2, float s, float alp1, float alp2) {

  float r = s*0.5;
  float ang = atan2(y2-y1, x2-x1);

  beginShape();
  fill(0, alp1);
  vertex(x1+cos(ang-HALF_PI)*r, y1+sin(ang-HALF_PI)*r);
  vertex(x1+cos(ang+HALF_PI)*r, y1+sin(ang+HALF_PI)*r);
  fill(0, alp2);
  vertex(x2+cos(ang+HALF_PI)*r, y2+sin(ang+HALF_PI)*r);
  vertex(x2+cos(ang-HALF_PI)*r, y2+sin(ang-HALF_PI)*r);
  endShape();

  int rc = max(4, int(r*PI*0.5));
  float da = PI/rc;
  fill(0, alp2);
  for (int i = 0; i < rc; i++) {
    float aa1 = ang-da*(i+0)+HALF_PI;
    float aa2 = ang-da*(i+1)+HALF_PI;
    beginShape();
    vertex(x2+cos(aa1)*r, y2+sin(aa1)*r);
    vertex(x2+cos(aa2)*r, y2+sin(aa2)*r);
    vertex(x2, y2);
    endShape();
  }

  fill(0, alp1);
  for (int i = 0; i <= rc; i++) {
    float aa1 = ang-da*(i+0)-HALF_PI;
    float aa2 = ang-da*(i+1)-HALF_PI;
    float amp1 = map(abs(i-rc*0.5), 0, rc*0.5, 0.8, 1);
    float amp2 = map(abs(i+1-rc*0.5), 0, rc*0.5, 0.8, 1);
    amp1 = pow(amp1, 0.8);
    amp2 = pow(amp2, 0.8);
    beginShape();
    vertex(x1+cos(aa1)*r, y1+sin(aa1)*r*amp1);
    vertex(x1+cos(aa2)*r, y1+sin(aa2)*r*amp2);
    vertex(x1, y1);
    endShape();
  }
}

class Spline {
  ArrayList<PVector> points;
  float dists[];
  float length;
  Spline(ArrayList<PVector> points) {
    this.points = points;
    calculate();
  }

  void calculate() {
    dists = new float[points.size()+1];
    length = 0; 

    int res = 10;
    for (int i = 0; i <= points.size(); i++) {
      float ndis = 0;
      PVector ant = getPointLin(i);
      for (int j = 1; j <= res; j++) {
        PVector act = getPointLin(i+j*1./res);
        ndis += ant.dist(act);
        ant = act;
      }
      dists[i] = length;
      if (points.size() != i) length += ndis;
    }
  }

  PVector getPointLin(float v) {
    v = constrain(v, 0, points.size());
    int ind = int(v);
    float m = v%1.;
    return calculatePoint(ind, m);
  }

  PVector getPoint(float v) {
    v = constrain(v, 0, 1)*length;
    int ind = 0;
    float antLen = dists[ind];
    float actLen = dists[ind+1];
    while (actLen < v && ind <= points.size()) { 
      ind++;
      antLen = actLen;
      actLen = dists[(ind+1)];
    }
    float m = map(v, antLen, actLen, 0, 1);
    return calculatePoint(ind, m);
  }

  float getAngle(float v) {
    return getDir(constrain(v, 0, 1)).heading();
  }

  PVector calculatePoint(int ind, float m) {
    int ps = points.size();
    int i1 = constrain(ind-1, 0, ps-1);
    int i2 = constrain(ind+0, 0, ps-1);
    int i3 = constrain(ind+1, 0, ps-1);
    int i4 = constrain(ind+2, 0, ps-1);
    PVector p1 = points.get(i1);
    PVector p2 = points.get(i2);
    PVector p3 = points.get(i3);
    PVector p4 = points.get(i4);
    float xx = curvePoint(p1.x, p2.x, p3.x, p4.x, m);
    float yy = curvePoint(p1.y, p2.y, p3.y, p4.y, m);
    float zz = curvePoint(p1.z, p2.z, p3.z, p4.z, m);
    return new PVector(xx, yy, zz);
  }

  PVector getDir(float v) {
    PVector act = getPoint(v);
    float v1 = constrain(v-0.001, 0, 1);
    float v2 = constrain(v+0.001, 0, 1);
    PVector p1 = act.copy().sub(getPoint(v1)).normalize();
    PVector p2 = getPoint(v2).sub(act).normalize();
    PVector aux = p1.add(p2).mult(0.5);
    return aux.copy().normalize();
  }

  PVector getCenter() {
    PVector center = new PVector();
    for (int i = 0; i < points.size(); i++) {
      center.add(points.get(i));
    }
    center.div(points.size());
    return center;
  }
}  