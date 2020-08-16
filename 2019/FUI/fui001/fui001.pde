ArrayList<Form> forms;
Grid grid;

color back = color(#121317);
int colors[] = {
  #4ECBFA, 
  #ED892B
};

int gridSize = 80;
int seed = 0;
PFont micro;
PShader shader;

void setup() { 
  size(960, 960, P2D);
  smooth(8);

  generate();

  micro = loadFont("micro12.vlw");
  //size(displayWidth, displayHeight, P2D);
  shader = loadShader("frag.glsl");
  shader.set("iResolution", float(width), float(height));
}

void draw() {
  /*
  if (frameCount%120 == 0)
   generate();
   */

  randomSeed(seed);
  noiseSeed(seed);
  shader.set("iGlobalTime", millis()/1000.0);

  background(back);
  strokeWeight(1);
  stroke(255, 6);
  blendMode(ADD);
  grid(gridSize/2, gridSize/2, width-gridSize, height-gridSize, int(gridSize/2));
  stroke(255, 20);
  strokeWeight(2);
  corners(gridSize/2, gridSize/2, width-gridSize, height-gridSize, 5);
  noStroke();
  fill(255, 40);
  gridBall(gridSize/2, gridSize/2, width-gridSize, height-gridSize, gridSize, 1);

  for (int i = 0; i < forms.size (); i++) {
    Form f = forms.get(i);
    //f.show();
    int t = int(random(6));
    if (t == 0) radar(f.x+f.w/2, f.y+f.h/2, f.w);
    if (t == 1) donut(f.x+f.w/2, f.y+f.h/2, f.w*random(0.2, 0.3), f.w*random(0.3, 0.45), int(f.w*random(0.2, random(1, 2))), f.w*random(0.2)*random(0.2, 1), colors[int(random(2))]);
    if (t == 2) graph(f.x, f.y, f.w, f.h, 10);
    if (t == 3) mapPoint(f.x, f.y, f.w, f.h, f.w*random(0.01, 0.16), f.w*random(0.08)*random(1));
    if (t == 4) gridLights(f.x, f.y, f.w, f.h, int(random(f.w*0.03, f.w*0.2)), int(random(f.h*0.03, f.h*0.2)));
    if (t == 5) listSlider(f.x, f.y, f.w, f.h, int(random(4, max(5, f.w/3))));
    /*
    
     mapPoint(250, 450, 150, 100, 4, 1);
     */
  }

  /*
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
   */
  filter(shader);


  boolean save = false;
  if (save) {
    if (frameCount%2 == 1)saveFrame("export3/####.png");
    if (frameCount >= 60*14) exit();
  }
}

void keyPressed() {
  if (key == 's') saveImage(); 
  else generate();
}

void generate() {
  seed = int(random(9999999)); 
  int tams[] = {
    40, 80
  }; 
  gridSize = tams[int(random(tams.length))];
  grid = new Grid(gridSize/2, gridSize/2, width-gridSize, height-gridSize, gridSize);
  newForms();
  randomColors();
}

void randomColors() {
  pushStyle();
  colorMode(HSB, 256, 256, 256);
  float c = random(256);
  float com[] = {
    -0.333, 0.333, 0.5, -0.5, 0.5
  };
  float c2 = (c+256*com[int(random(com.length))])%256;
  back = color(c, random(256), random(16));
  colors[0] = color(c2, random(120, 256), random(100, 256));
  colors[1] = color(c, random(160, 256), random(100, 256));
  popStyle();
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

void gridLights(float x, float y, float w, float h, float tw, float th) {
  float sw = max(2, int(tw*random(0.05, 0.3)));
  float sh = max(2, int(th*random(0.05, 0.3)));
  int cw = int(w/(tw+sw));
  int ch = int(h/(th+sh));
  float dx = (w-(cw*tw+(cw-1)*sw))/2;
  float dy = (h-(ch*th+(ch-1)*sh))/2;
  for (int j = 0; j < ch; j++) {
    for (int i = 0; i < cw; i++) {
      noStroke();
      float xx = dx+x+(tw+sw)*i;
      float yy = dy+y+(th+sh)*j;
      float a = max(2, noise(frameCount*0.2+xx+j)*512-256);
      fill(colors[0], a);
      rect(xx, yy, tw, th);
      rect(xx, yy, tw, th);
    }
  }
}

void listSlider(float x, float y, float w, float h, int c) {
  float th = int(w/c);
  float s = int(max(1, th*random(0.1, 0.2)));
  th -= s;
  for (int i = 0; i < c; i++) {
    float xx = x;
    float yy = y+(w/c)*i;
    slide(xx, yy, w, th, noise(i+frameCount*0.0008)+noise(i+frameCount*0.01)*0.05, colors[0]);
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
  w = w-m*2;
  h = h-m*2;
  fill(#0D0F0C, 200);
  blendMode(BLEND);
  rect(x+m, y+m, w, h);
  blendMode(ADD);
  corners(x+m, y+m, w, h, 5);
  float bs = 2;
  if (w/v <= 4) bs = (w/v)*0.1;
  float dx = w/(v+1);
  float ay = y+h/2;
  float vel = random(0.001, 0.1);
  for (int i = 0; i <= v; i++) {
    float ax = x+m+dx*(i-0.5);
    float xx = x+m+  dx*(i+0.5);
    float yy = y+h/2+(noise(xx*123+frameCount*vel)-0.5)*h;
    if (i > 0) line(xx, yy, ax, ay);
    ellipse(xx, yy, bs, bs);
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
  noStroke();
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
    d -= noise(frameCount*0.0014+i*random(10))*d/3;
    if (rr == 0) {
      noFill();
      stroke(colors[0], random(110, 220));    
      strokeWeight(min(max(1, d/3), random(1, 8)*random(1)));
      ellipse(x, y, d, d);
    }
    if (rr == 2 && random(1) < 0.2) {
      if (d < s*0.3) d += s*0.3;
      noStroke();
      fill(colors[1]); 
      int c = int(random(50, 90));
      float da = TWO_PI/c;
      float amp = d * random(0.3);
      float det = random(0.3, 0.5);
      float a = frameCount*random(-0.005, 0.005);
      for (int j = 0; j < c; j++) {
        float aa = da*j+a;
        float r = d/2-noise(j*det)*amp;
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
      }
    }
  }
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}
