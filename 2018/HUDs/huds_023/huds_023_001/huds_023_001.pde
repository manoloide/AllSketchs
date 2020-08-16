int seed = int(random(999999));

void setup() {
  size(960, 960, P2D);
  smooth(8);
  pixelDensity(2);

  generate();
}

class Rect{
   float x, y, w, h;
   Rect(float x, float y, float w, float h){
      this.x = x; 
      this.y = y;
      this.w = w;
      this.h = h;
   }
}

void draw() {

  randomSeed(seed);
  background(0);

  float ss = 60;
  
  noFill();
  stroke(255, 50);
  gridRect(0, 0, width, height, ss, 5);
  stroke(255);
  gridPoint(0, 0, width, height, ss);
  
  ArrayList<Rect> rects = new ArrayList<Rect>();
  rects.add(new Rect(0, 0, width, height));
  int div = int(random(20)*random(0.2, 1));
  for(int i = 0; i < div; i++){
     int ind = int(random(rects.size()));
     Rect r = rects.get(ind);
     int cw = int(r.w/ss);
     int ch = int(r.h/ss);
     if(cw < 2 || ch < 2) continue;
     int nw = int(random(1, cw));
     int nh = int(random(1, ch));
     rects.add(new Rect(r.x, r.y, nw*ss, nh*ss));
     rects.add(new Rect(r.x+nw*ss, r.y, (cw-nw)*ss, nh*ss));
     rects.add(new Rect(r.x+nw*ss, r.y+nh*ss, (cw-nw)*ss, (ch-nh)*ss));
     rects.add(new Rect(r.x, r.y+nh*ss, nw*ss, (ch-nh)*ss));
     rects.remove(ind);
  }
  
  for(int i = 0; i < rects.size(); i++){
     Rect r = rects.get(i);
     noStroke();
     fill(20, 220);
     rect(r.x+2, r.y+2, r.w-4, r.h-4);
     
     int w = int(r.w-8);
     int h = int(r.h-8);
     PGraphics render = createGraphics(w, h, P3D);
     render.beginDraw();
     render.background(10);
     render.translate(w*0.5, h*0.5);
     render.noFill();
     render.stroke(255);
     render.sphere(w);
     render.endDraw();
     
     image(render, r.x+4, r.y+4);
     
  }
  
  
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
}

void saveImage() {
  String timestamp = year() + nf(month(), 2) + nf(day(), 2) + "-"  + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2);
  saveFrame(timestamp+".png");
}


void gridPoint(float x, float y, float w, float h, float ss) {
  int cw = int(w/ss);
  int ch = int(h/ss);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      point(i*ss, j*ss);
    }
  }
}

void gridRect(float x, float y, float w, float h, float dd, float ss) {
  int cw = int(w/dd);
  int ch = int(h/dd);
  pushStyle();
  rectMode(CENTER);
  for (int j = 0; j <= ch; j++) {
    for (int i = 0; i <= cw; i++) {
      rect(i*dd, j*dd, ss, ss);
    }
  }
  popStyle();
}
