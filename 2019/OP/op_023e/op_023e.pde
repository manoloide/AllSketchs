import toxi.math.noise.SimplexNoise;

//758573 315342 206079
int seed = 206079;//int(random(999999));

// 300 DPI = 8268
// 600 DPI = 16536

int nwidth = 960;//16536 //8268; //960; //16536
int nheight = 960;//16536 //8268; //960; //16536
int swidth = 960; 
int sheight = 960;
int twidth = 960;//960*2; 
int theight = 960;//960*2;
float scale = 1;

boolean export = false;
PGraphics render; 

void settings() {
  scale = nwidth*1./swidth;
  size(twidth, theight, P2D);
  smooth(8);
  pixelDensity(2);
}

void setup() {

  if (export) {
    render = createGraphics(twidth, theight, P2D);

    int cw = int(nwidth/twidth);
    int ch = int(nheight/theight);

    for (int j = 0; j < ch; j++) {
      for (int i = 0; i < cw; i++) {
        generate(-i*int(twidth), -j*int(theight));
        saveImage();
      }
    }

    exit();
  } else {
    render = createGraphics(int(swidth*scale), int(sheight*scale), P2D);
    generate(0, 0);
  }
}

void draw() {
}

void keyPressed() {
  if (key == 's') saveImage();
  else {
    seed = int(random(999999));
    generate(0, 0);
  }
}



void generate(int dx, int dy) { 

  println(seed);

  render.beginDraw();

  randomSeed(seed);
  noiseSeed(seed);

  render.background(0);
  render.pushMatrix();
  render.translate(dx, dy);
  render.scale(scale);

  /*
  int gc = 20;
   float gs = swidth*1./gc;
   render.noStroke();
   for (int j = 0; j < gc; j++) {
   for (int i = 0; i < gc; i++) {
   if ((i+j)%2 == 0) render.fill(0);
   else render.fill(255);
   
   render.rect(i*gs, j*gs, gs, gs);
   }
   }
   */

  float des = random(10000);
  float det = random(0.0001, 0.00014)*0.9;

  float desCol = random(10000);
  float detCol = random(0.001, 0.004)*0.15;

  float desDes = random(10000);
  float detDes = random(0.0008, 0.001);

  float desAng = random(10000);
  float detAng = random(0.001, 0.004)*0.2;

  int cc = 180;
  float ss = swidth*1./cc;

  float stw = twidth/scale;
  float sth = theight/scale;

  float desvc = random(10000);
  float detvc = random(0.0002, 0.0004);
  
  float desStr = random(1000);
  float detStr = random(0.001, 0.0003);

  strokeCap(SQUARE);
  for (int k = -10; k < cc+10; k++) {
    for (int j = -10; j < cc+10; j++) {
      ArrayList<PVector> points = new ArrayList<PVector>();
      float x = j*ss;
      float y = k*ss;

      float a = noise(desAng+x*detAng, desAng+y*detAng)*1*TAU;
      float d = pow(noise(desDes+x*detDes, desDes+y*detDes), 2)*12;

      x += cos(a)*d;
      y += sin(a)*d;

      float ang = 0;

      boolean in = false;

      noiseDetail(2);
      for (int i = 0; i < 100; i++) {

        ang = ((float) SimplexNoise.noise(des+x*det, des+y*det)*2-1)*2*HALF_PI;
        ang += random(-0.02, 0.02)*random(1);
        x += cos(ang)*0.5;
        y += sin(ang)*0.5;

        if (x > -1 && x <= swidth+1 && y > -1 && y < sheight+1) {
          points.add(new PVector(x, y));
        }

        if (x > -dx/scale-50 && x <= -dx/scale+stw+50 && y > -dy/scale-50 && y <= -dy/scale+sth+50) {
          in = true;
        }
      }

      if (points.size() > 1 && in) {
        noiseDetail(4);
        float str = 1*0.5;;
        PVector p1 = points.get(0);
        PVector p2 = points.get(1);
        float aa = atan2(p2.y-p1.y, p2.x-p1.x);
        float nc = noise(desCol+p1.x*detCol, desCol+p1.y*detCol)*50;
        float velCol = noise(desvc+p1.x*detvc, desvc+p1.y*detvc)*0.01;//random(0.01)*random(1);
        float modVelCol = 1;//random(0.999, 1.001);
        //stroke(lerpColor(color(240), color(#D80B0B), curve(nc, 12)), 170);
        
        render.noFill();
        render.stroke(255, 160);
        render.noStroke();
        //render.strokeWeight(0.8+noise(desStr+p.x*detStr, desStr+p.y*detStr)*0.3);
        render.beginShape(QUAD_STRIP);
        for (int i = 0; i < points.size(); i++) {
          p1 = p2;
          p2 = points.get(i);
          nc += velCol;
          
          if(i == 0) continue;
          
          aa = atan2(p2.y-p1.y, p2.x-p1.x);
          
          //velCol *= modVelCol;
          render.fill(getColor(curve(nc%1, 2)*colors.length), 170);
          render.vertex(p2.x+cos(aa-HALF_PI)*str, p2.y+sin(aa-HALF_PI)*str);
          render.vertex(p2.x+cos(aa+HALF_PI)*str, p2.y+sin(aa+HALF_PI)*str);
        }
        render.endShape();
      }
    }
  }

  render.popMatrix();
  render.endDraw();

  image(render, 0, 0);
}


float curve(float val, float pwr) {
  float nv = val;
  if (val < 0.5) {
    nv = pow(map(val, 0.0, 0.5, 0, 1), pwr);
  } else {
    nv = pow(map(val, 0.5, 1.0, 1, 0), pwr);
  }
  return nv;
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  //render.save(timestamp+"-"+seed+".png");
  saveFrame(timestamp+"-"+seed+".png");
}

int colors[] = {#000000, #D80B0B, #F0F0F0, #D80B0B};
//int colors[] = {#FEFEFE, #FEBDE5, #FE9446, #FBEC4D, #00ABA3};
//int colors[] = {#01EEBA, #E8E3B3, #E94E6B, #F08BB2, #41BFF9};
//int colors[] = {#000000, #eeeeee, #ffffff};x
//int colors[] = {#DFAB56, #E5463E, #366A51, #2884BC};
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
