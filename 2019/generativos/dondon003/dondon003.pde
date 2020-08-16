int seed = int(random(999999));


float nwidth =  960; 
float nheight = 960;
float swidth = 960; 
float sheight = 960;
float scale = 1;

boolean export = false;

PFont font;

void settings() {
  scale = nwidth/swidth;
  size(int(swidth*scale), int(sheight*scale), P3D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  font = createFont("HalogenbyPixelSurplus-Regular", 12, false);

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

class Pixel {
  float x, y;
  color col;
  Pixel(float x, float y, color col) {
    this.x = x; 
    this.y = y; 
    this.col = col;
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

  //background(lerpColor(rcol(), color(0), random(40)));
  background(0);

  translate(width*0.5, height*0.5, 200);



  float lrx = random(-0.1, 0.1);
  float lry = random(-0.1, 0.1);
  float lrz = -1;//random(-1, 1);
  ambientLight(40, 30, 40);
  directionalLight(255, 240, 245, lrx, lry, lrz);

  rotateX(HALF_PI*random(0.08));
  rotateZ(HALF_PI*random(0.5, 2));

  stroke(0, 40);
  strokeWeight(0.5);

  int cc = 900;
  float size = width*1.41;
  float ss = size*1./cc;


  ArrayList<PVector> points = new ArrayList<PVector>();

  for (int i = 0; i < 10; i++) {
    int x = int(random(cc*1./50))*50-cc/2;
    int y = int(random(cc*1./50))*50-cc/2;
    points.add(new PVector(x*ss, y*ss));
  }

  PGraphics screen = createGraphics(cc, cc);

  screen.beginDraw();




  float detCol = random(0.02, 0.026)*0.04;
  float desCol = random(1000);

  float detSize = random(0.02, 0.03)*0.4;
  float desSize = random(1000);
  float detAmp = random(0.02, 0.03);
  float desAmp = random(1000);

  noiseDetail(8);

  DoubleNoise dn = new DoubleNoise();
  dn.noiseDetail(9);
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      int col = rcol();


      double amp = 8+2.2*Math.max(0, Math.pow(dn.noise(desAmp+i*detAmp, desAmp+j*detAmp), 9.4)-0.4);
      double val = dn.noise(desCol+j*detCol, desCol+i*detCol, dn.noise(desCol+i*detCol, desCol+j*detCol)*8)*amp;
      col = lerpColor(getColor((float)Math.pow(val, 1.2)*2), color(255), 0.0);

      screen.set(i, j, col);
    }
  }

  for (int i = 0; i < 400; i++) {
    int xx = int(random(cc));
    int yy = int(random(cc));
    float ic = random(10);
    float dc = random(0.1)*random(1);
    screen.set(xx, yy, rcol());
    for (int j = 1; j < random(80); j++) {
      screen.set(xx+j, yy, getColor(ic+dc*j));
    }
  }

  float gltDes = random(1000);
  float gltDet = random(0.001);

  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      int xx = int(random(cc));
      int yy = int(random(cc));

      if (noise(gltDes+xx*gltDet, gltDes+yy*gltDet) < 0.1) continue;

      //screen.set(xx, yy, color(255*random(1)*random(1), 255*random(1)*random(1), 255*random(1)*random(1)));
    }
  }


  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    int x = int(p.x/ss);
    int y = int(p.y/ss);
    screen.set(x, y, color(240));
    for (int j = 1; j <= 10; j++) {
      screen.set(x, y-1, color(40));
    }
    
    screen.textFont(font);
    screen.text("ABC", x, y);
  }

  for (int j = 0; j < cc; j+=50) {
    for (int i = 0; i < cc; i++) {
      screen.set(i, j, lerpColor(screen.get(i, j), color(255), 0.1));
      screen.set(j, i, lerpColor(screen.get(j, i), color(255), 0.1));
    }
  }

  for (int j = 0; j < 20; j++) {
    if (random(1) < 0.5) {
      int yy = int(random(cc));
      int dg = int(random(1, 5));
      for (int i = cc-1; i > dg; i--) {
        screen.set(i, yy, screen.get(i-dg, yy));
      }
    } else {
      int xx = int(random(cc));
      int dg = int(random(1, 5));
      for (int i = cc-1; i > dg; i--) {
        screen.set(xx, i, screen.get(xx, i-dg));
      }
    }
  }
  screen.endDraw();


  rectMode(CENTER);
  for (int i = 0; i < points.size(); i++) {
    PVector p = points.get(i);
    pushMatrix();
    translate(p.x, p.y, 10);
    //fill(20);
    stroke(0, 200);
    noFill();
    box(1, 1, 20);
    //noStroke();
    rect(0, 0, 80, 80);
    popMatrix();
  }


  stroke(0, 20);
  noStroke();
  noStroke();
  blendMode(ADD);
  float ms = ss/3.;
  float smoothCol = 0.8;
  boolean colorsPixel = false;
  for (int j = 0; j < cc; j++) {
    for (int i = 0; i < cc; i++) {
      pushMatrix();
      translate(i*ss-size*0.5, j*ss-size*0.5);
      float noi = (0.8+pow(noise(desSize+i*detSize, desSize+j*detSize), 0.8)*0.2);
      float s = ss*random(0.98, 1)*noi;
      //box(s);
      int col = screen.get(i, j);

      if (colorsPixel) {
        float r = red(col)*random(0.98, 1);
        float g = green(col)*random(0.98, 1);
        float b = blue(col)*random(0.98, 1);
        fill(r, g*smoothCol, b*smoothCol);
        rect(0, -ms, s, ms);
        fill(r*smoothCol, g, b*smoothCol);
        rect(0, 0, s, ms);
        fill(r*smoothCol, g*smoothCol, b);
        rect(0, +ms, s, ms);
      } else {
        fill(col);
        rect(0, 0, s, s);
      }
      popMatrix();
    }
  }
  blendMode(BLEND);
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+"-"+seed+".png");
}

//int colors[] = {#121B4B, #028594, #016C40, #FBAF34, #CF3B13, #E55E7F, #F0D5CA};
//int colors[] = {#ffffff, #B0E7FF, #143585, #5ACAA2, #D08714, #F98FC0};
//int colors[] = {#77ABC1, #669977, #DD9931, #AA3320, #33221F, #CE7353, #BC6657, #97AD67, #CC3211, #9D6A7F};
//int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80, #242527, #FCFCFA};
int colors[] = {#043387, #0199DC, #BAD474, #FBE710, #FFE032, #EB8066, #E7748C, #DF438A, #D9007E, #6A0E80};
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
  return lerpColor(c1, c2, pow(v%1, random(1.4, 2.4)));//2.4)));
}
