int colors[] = {
  #4ECBFA, 
  #ED892B
};

int seed = int(random(9999999));
PFont micro;
PShader shader;

void setup() {
  size(600, 600, P2D);
  smooth(8);
  micro = loadFont("micro12.vlw");
  //size(displayWidth, displayHeight, P2D);
  shader = loadShader("frag.glsl");
  shader.set("iResolution", float(width), float(height));
}

void draw() {
  /*
  if (frameCount%120 == 0)
    seed++;
    */

  randomSeed(seed);
  noiseSeed(seed);
  shader.set("iGlobalTime", millis()/1000.0);
  color back = color(#121317);
  /*
  pushStyle();
  colorMode(HSB, 256, 256, 256);
  back = color(random(256), random(256), random(40));
  colors[0] = color(random(256), random(100, 256), random(100,256));
  colors[1] = color(random(256), random(100, 256), random(100,256));
  popStyle();
  */
  
  background(back);
  strokeWeight(1);
  stroke(255, 10);
  blendMode(ADD);
  grid(50, 50, width-100, height-100, 50);
  stroke(255, 30);
  strokeWeight(2);
  corners(50, 50, width-100, height-100, 5);
  noStroke();
  fill(255, 120);
  gridBall(50, 50, width-100, height-100, 50, 1);

  for (int i = 0; i < 20; i++) {
    float x = 50; 
    float y = 50; 
    float w = 100;
    float h = 3;
    float s = 5;
    slide(x, y+(h+s)*i, w, h, noise(i+frameCount*0.0008)+noise(i+frameCount*0.01)*0.05, colors[0]);
  }

  textFont(micro);
  textAlign(LEFT, TOP);
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < 16; i++) {
      float v = random(0.9, 1)-i/18.+noise(i*35+j*84+frameCount*0.05)*0.191;
      int d = int(noise(i*355+frameCount*0.005)*9);
      if (j > 0) v /= 100;
      float x = 2+450+j*50;
      float y = 2+200+i*50/4;
      int c =  colors[(i == 0)? 1 : 0];
      fill(c, random(200-i*5, 226)+noise(frameCount*0.1)*20);
      text(v, x, y);
    }
  }

  gridLights(200, 50, 8, 18, 35, 5, 2, 2);
  //gridLights(450, 200, 8, 9, 10, 5, 2, 2);
  //gridLights(200, 450, 3, 18, 40, 5, 2, 2);

  radar(width/2, height/2, width*0.48);
  donut(100, 300, 30, 45, 50, 16, colors[0]);
  donut(100, 400, 30, 45, 50, 16, colors[0]);
  //spherePoints(width/2, height/2, width*0.6, 30, colors[0]);

  donut(475, 475, width*0.05, width*0.1, 100, 16, colors[1]);

  graph(50, 450, 200, 100, 10);
  mapPoint(250, 450, 150, 100, 4, 1);
  filter(shader);

  boolean save = false;
  if (save) {
    saveFrame("export/####.png");
    if (frameCount >= 60*20) exit();
  }
}

void keyPressed() {
  if (key == 's') saveImage(); 
  else seed = int(random(9999999));
}

void grid(float x, float y, float w, float h, int s) {
  w -= w%s; 
  h -= h%s; 
  for (float i = x; i <= x+w; i+=s) {
    line(i, y, i, y+h);
  }
  for (float i = y; i <= y+h; i+=s) {
    line(x, i, x+w, i);
  }
}

void gridBall(float x, float y, float w, float h, int s, int bs) {
  for (float j = x; j <= x+w; j+=s) {
    for (float i = y; i <= y+h; i+=s) {
      ellipse(i, j, bs, bs);
    }
  }
}

void gridLights(float x, float y, float w, float h, float cw, float ch, float sw, float sh) {
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      noStroke();
      float xx = x+(w+sw)*i;
      float yy = y+(h+sh)*j;
      float a = max(2, noise(frameCount*0.2+xx+j)*512-256);
      fill(colors[0], a);
      rect(xx, yy, w, h);
      rect(xx, yy, w, h);
    }
  }
}

void spherePoints(float x, float y, float s, int c, int col) {
  PVector p[] = new PVector[c];
  float da1 = frameCount*random(-0.002, 0.002);
  float da2 = frameCount*random(-0.002, 0.002);
  float d = s/2;
  for (int i = 0; i < c; i++) {
    float a1 = random(TWO_PI)+da1;
    float a2 = random(TWO_PI)+da2;
    float xx = cos(a1)*cos(a2)*d;
    float yy = cos(a1)*sin(a2)*d;
    float zz = sin(a1)*d;
    p[i] = new PVector(xx, yy, zz);
  }
  /*
  fill(col, 200);
   for (int i = 0; i < c; i++) {
   ellipse(p[i].x, p[i].y, 2, 2);
   }
   */


  int w = int(s+10); 
  PGraphics gra = createGraphics(w, w, P3D);
  gra.beginDraw();
  gra.translate(w/2, w/2, -200);
  gra.stroke(col, 120);
  gra.strokeWeight(1);
  gra.blendMode(ADD);
  float sen = s*0.2;
  for (int j = 0; j < c-1; j++) {
    for (int i = j+1; i < c; i++) {
      if (dist(p[i].x, p[i].y, p[i].z, p[j].x, p[j].y, p[i].z) < sen) {
        gra.line(p[i].x, p[i].y, p[i].z, p[j].x, p[j].y, p[i].z);
      }
    }
  }
  gra.endDraw();
  pushStyle();
  imageMode(CENTER);
  image(gra, x, y);
  popStyle();
}

void graph(float x, float y, float w, float h, int v) {
  stroke(255, 30);
  strokeWeight(1);
  int m = 3;
  fill(#0D0F0C, 200);
  blendMode(BLEND);
  rect(x+m, y+m, w-m*2, h-m*2);
  blendMode(ADD);
  corners(x+m, y+m, w-m*2, h-m*2, 5);

  float dx = w/(v+1);
  float ay = y+h/2;
  float vel = random(0.001, 0.1);
  for (int i = 0; i <= v; i++) {
    float ax = x+dx*(i-0.5);
    float xx = x+dx*(i+0.5);
    float yy = y+h/2+(noise(xx*123+frameCount*vel)-0.5)*h;
    if (i > 0) line(xx, yy, ax, ay);
    ellipse(xx, yy, 2, 2);
    ay = yy;
  }
}

void mapPoint(float x, float y, float w, float h, float t, float s) {
  int cw = int(w/(t+s));
  int ch = int(h/(t+s));
  float dx = (w-(cw*t+(cw-1)*s))/2;
  float dy = (h-(ch*t+(ch-1)*s))/2;
  noStroke();
  float z = random(0.01, 0.05);
  float tx = frameCount*random(-0.03, 0.03);
  float ty = frameCount*random(-0.03, 0.03);
  for (float j = 0; j < ch; j++) {
    for (float i = 0; i < cw; i++) {
      float xx = x+dx+i*(t+s)+t/2;
      float yy = y+dy+j*(t+s)+t/2;
      float v = noise(xx*z+tx, yy*z+ty);
      float a = max(2, v*512-256);
      fill(colors[0], a);
      ellipse(xx, yy, t, t);
      ellipse(xx, yy, t, t);
    }
  }
}

void corners(float x, float y, float w, float h, int s) {
  line(x, y, x+s, y);
  line(x, y, x, y+s);
  line(x+w, y, x+w-s, y);
  line(x+w, y, x+w, y+s);
  line(x+w, y+h, x+w-s, y+h);
  line(x+w, y+h, x+w, y+h-s);
  line(x, y+h, x+s, y+h);
  line(x, y+h, x, y+h-s);
}

void slide(float x, float y, float w, float h, float l, int col) {
  l = constrain(l, 0, 1);
  fill(col, 30);
  rect(x, y, w, h);
  fill(col, 220);
  rect(x, y, w*l, h);
}

void donut(float x, float y, float minSize, float maxSize, int c, float sen, int col) {
  PVector p[] = new PVector[c];
  float da = frameCount*random(-0.002, 0.002);
  for (int i = 0; i < c; i++) {
    float a = random(TWO_PI)+da;
    float d = random(minSize, maxSize);
    p[i] = new PVector(x+cos(a)*d, y+sin(a)*d);
  }
  stroke(col, 20);
  strokeWeight(1);
  for (int j = 0; j < c-1; j++) {
    for (int i = j+1; i < c; i++) {
      if (dist(p[i].x, p[i].y, p[j].x, p[j].y) < sen) {
        line(p[i].x, p[i].y, p[j].x, p[j].y);
      }
    }
  }
  noStroke();
  fill(col, 200);
  for (int i = 0; i < c; i++) {
    ellipse(p[i].x, p[i].y, 2, 2);
  }
}

void radar(float x, float y, float s) {
  int cc = int(random(4, 20));
  for (int i = 0; i < cc; i++) {
    int rr = int(random(4));
    float d = s*random(0.2, 1);
    d -= noise(frameCount*0.0014+i*random(10))*d/2;
    if (rr == 0) {
      noFill();
      stroke(colors[0], random(110, 220));    
      strokeWeight(min(max(1, d/3), random(1, 8)*random(1)));
      ellipse(x, y, d, d);
    }
    if (rr == 2 && random(1) < 0.2) {
      if (d < 60) d += 60;
      noStroke();
      fill(colors[1]); 
      int c = int(random(50, 90));
      float da = TWO_PI/c;
      float amp = d * random(0.3);
      float det = random(0.3, 0.5);
      float a = frameCount*random(-0.005, 0.005);
      for (int j = 0; j < c; j++) {
        float aa = da*j+a;
        float r = d/2 -noise(j*det)*amp;
        ellipse(x+cos(aa)*r, y+sin(aa)*r, 2, 2);
      }
    }
    if (rr == 3) {
      noFill(); 
      int c = int(random(3, 40)); 
      stroke(colors[(c > 20 && random(1) < 0.2)? 1 : 0]); 
      float da = TWO_PI/c; 
      float a = frameCount*random(-0.02, 0.02); 
      float anc = random(0.2, 0.9);
      float amp = random(0.8, 0.95);
      strokeCap(SQUARE); 
      strokeWeight(1);
      for (int j = 0; j < c; j++) {
        float aa = da*j+a;
        float r = d/2;
        float xx = cos(aa);
        float yy = sin(aa);
        line(x+xx*r, y+yy*r, x+xx*r*amp, y+yy*r*amp);
        //arc(x, y, d, d, da*j+a, da*(j+anc)+a);
      }
    }
  }
}


void saveImage() {
  int n = (new File(sketchPath)).listFiles().length-1; 
  saveFrame(nf(n, 3)+".png");
}

